<?php

namespace app\service\perfil;

use Yii;
use DateTime;
use Throwable;
use app\models\admin\Pessoa;
use app\lib\PagamentoException;
use app\models\admin\PlanoTipo;
use app\models\admin\Assinatura;
use app\lib\helper\RequisicaoApi;
use app\lib\dicionario\StatusAssinatura;
use app\models\admin\permissao\AuthAssignment;

class AssinaturaServices
{
    private PlanoTipo $plano;
    private Pessoa $pessoa;
    private ?int $user_id = null;
    private ReverteAssinaturaService $reverteAssinaturaService;

    public function __construct(
        private string $token,
        private int $plano_tipo_id
    ) {
        $this->plano =  PlanoTipo::findOne($plano_tipo_id);
        $user = Yii::$app->user->identity;
        $this->pessoa = $user->pessoa;
        $this->user_id = Yii::$app->user->id;
        $this->reverteAssinaturaService = new ReverteAssinaturaService();
    }

    public function save()
    {
        $transaction = Yii::$app->db->beginTransaction();
        try {
            $this->atualizaAssinaturasAntigas();
            $apiAssinaturaId = $this->criaAssinaturaAPI();
            $this->savaAssinaturaDB($apiAssinaturaId);
            $this->addPermissao();
            $transaction->commit();
            return ['resp' => true, 'msg' => 'Tudo certo!'];
        } catch (PagamentoException $e) {
            $transaction->rollBack();
            $this->reverteAssinaturaService->corrige();
            throw new PagamentoException($e->getMessage());
        } catch (Throwable $e) {
            $transaction->rollBack();
            $this->reverteAssinaturaService->corrige();
            throw new PagamentoException('Ocorreu um erro inesperado!');
        }
    }


    private function atualizaAssinaturasAntigas()
    {
        $now = new DateTime();
        $data = $now->format('Y-m-d');
        $assinaturas = Assinatura::find()
            ->innerJoinWith(['planoTipo'])
            ->where(['user_id' => $this->user_id])
            ->andWhere(['data_fim' => null])
            ->andWhere(['status' => StatusAssinatura::AUTHORIZED])
            ->andWhere(['plano_tipo.nome' => PlanoTipo::PLANO_PADRAO])
            ->all();

        foreach ($assinaturas as $assinatura) {
            $assinatura->data_fim = $data;
            $assinatura->status = StatusAssinatura::CANCELLED;
            if (!$assinatura->save()) {
                throw new PagamentoException("As assinaturas não foram atualizadas!");
            }
        }
    }


    private function criaAssinaturaAPI()
    {
        $planoDescricao = $this->plano->planoDescricao;
        $json  = '{
                                    "auto_recurring": {
                                        "frequency": ' . $planoDescricao->frequencia . ',
                                        "frequency_type": "' . $planoDescricao->tipo_frequencia . '",
                                        "currency_id": "' . $planoDescricao->currency_id . '",
                                        "transaction_amount":"' . $planoDescricao->valor_plano . '"
                                      
                                    },
                                    "back_url": "' . $planoDescricao->back_url . '",   
                                    "card_token_id":"' . $this->token . '",
                                    "payer_email":"' . $this->pessoa->email . '",
                                    "preapproval_plan_id":"' . $planoDescricao->plano_api_id . '",
                                    "status":"' . StatusAssinatura::AUTHORIZED . '"
                                    }';

        $requisicaoApi = new RequisicaoApi(Yii::$app->mercado_pago->url . 'preapproval', 'POST');
        $id = $requisicaoApi->enviaJson($json);
        $this->reverteAssinaturaService->addAssinaturasCriadas($id);
        return $id;
    }

    private function savaAssinaturaDB($apiAssinaturaId)
    {
        $assinatura = new Assinatura();
        $assinatura->user_id = $this->user_id;
        $assinatura->plano_tipo_id = $this->plano->id;
        $assinatura->data_inicio = date('Y-m-d');
        $assinatura->id_api_assinatura = $apiAssinaturaId;
        $assinatura->status = StatusAssinatura::AUTHORIZED;
        if (!$assinatura->save()) {
            throw new PagamentoException("Erro ao salvar assinatura no BD !");
        }
    }

    private function addPermissao()
    {
        $objetoData = new \DateTime;
        $data = (int) $objetoData->getTimestamp();
        $authAssignment = AuthAssignment::find()->where(['user_id' => strval($this->user_id)])->one();
        if (empty($authAssignment)) {
            $authAssignment = new AuthAssignment();
        }
        $authAssignment->user_id = \strval($this->user_id);
        $authAssignment->item_name = $this->plano->auth_item_name;
        $authAssignment->created_at = $data;

        if (!$authAssignment->save()) {
            throw new PagamentoException("Erro ao adicionar permissão !");
        }
    }
}
