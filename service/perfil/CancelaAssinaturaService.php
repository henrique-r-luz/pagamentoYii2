<?php

namespace app\service\perfil;

use Yii;
use Throwable;
use app\lib\PagamentoException;
use app\models\admin\PlanoTipo;
use app\models\admin\Assinatura;
use app\lib\helper\RequisicaoApi;
use app\lib\dicionario\StatusAssinatura;

class CancelaAssinaturaService
{

    public function __construct(private Assinatura $assinatura)
    {
    }

    public function cancela()
    {
        $transaction = Yii::$app->db->beginTransaction();
        try {
            $this->cancelaApi();
            $this->aletraDadosAssinatura();
            $plano = PlanoTipo::find()->where(['nome' => PlanoTipo::PLANO_PADRAO])->one();
            $this->criaAssinaturaPadrao($this->assinatura->user_id, $plano->id);
            $transaction->commit();
        } catch (PagamentoException $e) {
            $transaction->rollBack();
            throw new PagamentoException($e->getMessage());
        } catch (Throwable $e) {
            $transaction->rollBack();
            throw new PagamentoException('Ocorreu um erro inesperado!');
        }
    }


    public function cancelaApi()
    {
        $json  = '{
            "status":"' . StatusAssinatura::CANCELLED . '"
          }';

        $requisicaoApi = new RequisicaoApi(Yii::$app->mercado_pago->url . 'preapproval/' . $this->assinatura->id_api_assinatura, 'PUT');
        $requisicaoApi->enviaJson($json);
    }


    public function aletraDadosAssinatura()
    {

        $this->assinatura->status = StatusAssinatura::CANCELLED;
        $this->assinatura->data_fim = date('Y-m-d');
        if (!$this->assinatura->save()) {
            throw new PagamentoException("Erro ao salvar assinatura no BD !");
        }
    }


    public function criaAssinaturaPadrao($user_id, $plano_id)
    {
        $assinatura = new Assinatura();
        $assinatura->user_id = $user_id;
        $assinatura->plano_tipo_id = $plano_id;
        $assinatura->data_inicio = date('Y-m-d');
        $assinatura->status = StatusAssinatura::AUTHORIZED;
        if (!$assinatura->save()) {
            throw new PagamentoException("Erro ao salvar assinatura no BD !");
        }
    }
}
