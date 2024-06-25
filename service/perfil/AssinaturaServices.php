<?php

namespace app\service\perfil;

use Yii;
use DateTime;
use Throwable;
use app\models\admin\Pessoa;
use app\lib\PagamentoException;
use app\models\admin\PlanoTipo;
use app\models\admin\Assinatura;
use app\lib\dicionario\StatusAssinatura;
use app\models\admin\permissao\AuthAssignment;

class AssinaturaServices
{
    private PlanoTipo $plano;
    private Pessoa $pessoa;
    private ?int $user_id = null;

    public function __construct(
        private string $token,
        private int $plano_tipo_id
    ) {
        $this->plano =  PlanoTipo::findOne($plano_tipo_id);
        $user = Yii::$app->user->identity;
        $this->pessoa = $user->pessoa;
        $this->user_id = Yii::$app->user->id;
    }

    public function save()
    {
        $this->atualizaAssinaturasAntigas();
        return $this->criaAssinatura();
    }


    private function atualizaAssinaturasAntigas()
    {
        $now = new DateTime();
        $data = $now->format('Y-m-d');
        $assinaturas = Assinatura::find()
            ->where(['user_id' => $this->user_id])
            ->andWhere(['data_fim' => null])
            ->andWhere(['status' => StatusAssinatura::AUTHORIZED])
            ->all();

        foreach ($assinaturas as $assinatura) {
            $this->cancelaAssinaturaAPI($assinatura->id_api_assinatura);
            $assinatura->data_fim = $data;
            $assinatura->status = StatusAssinatura::CANCELLED;
            if (!$assinatura->save()) {

                throw new PagamentoException("As assinaturas não foram atualizadas!");
            }
        }
    }

    private function cancelaAssinaturaAPI($id_api)
    {
        if ($id_api == null || $id_api == '') {
            return;
        }
        $curl = curl_init();
        $json  = '{
                    "status":"' . StatusAssinatura::CANCELLED . '"
                  }';


        curl_setopt_array($curl, array(
            CURLOPT_URL => Yii::$app->mercado_pago->url . 'preapproval/' . $id_api,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'PUT',
            CURLOPT_POSTFIELDS => $json,
            CURLOPT_HTTPHEADER => array(
                "Content-Type: application/json",
                "Authorization: Bearer " . Yii::$app->mercado_pago->token
            ),
        ));

        $response = curl_exec($curl);

        curl_close($curl);
        $resp = \json_decode($response, true);

        if (empty($resp['id'])) {

            throw new PagamentoException("O cancelamento da assinatura na api do mercado livre não funcionou!");
        }
        return $resp['id'];
    }


    private function criaAssinatura()
    {
        $transaction = Yii::$app->db->beginTransaction();
        try {
            $apiAssinaturaId = $this->criaAssinaturaAPI();
            $this->savaAssinaturaDB($apiAssinaturaId);
            $this->addPermissao();
            $transaction->commit();
            return ['resp' => true, 'msg' => 'Tudo certo!'];
        } catch (PagamentoException $e) {
            $transaction->rollBack();
            throw new PagamentoException($e->getMessage());
        } catch (Throwable $e) {
            $transaction->rollBack();
            throw new PagamentoException('Ocorreu um erro inesperado!');
        }
    }

    private function criaAssinaturaAPI()
    {
        $planoDescricao = $this->plano->planoDescricao;
        $curl = curl_init();
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


        curl_setopt_array($curl, array(
            CURLOPT_URL => Yii::$app->mercado_pago->url . 'preapproval',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => $json,
            CURLOPT_HTTPHEADER => array(
                "Content-Type: application/json",
                "Authorization: Bearer " . Yii::$app->mercado_pago->token
            ),
        ));

        $response = curl_exec($curl);

        curl_close($curl);
        $resp = \json_decode($response, true);

        if (empty($resp['id'])) {
            print_r($resp);
            exit();
            throw new PagamentoException("A assinatura na api do mercado livre não foi criada!");
        }
        return $resp['id'];
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
