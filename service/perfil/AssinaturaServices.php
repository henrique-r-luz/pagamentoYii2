<?php

namespace app\service\perfil;

use Yii;
use DateTime;
use DateTimeZone;
use app\models\admin\Pessoa;
use app\lib\PagamentoException;
use app\models\admin\PlanoTipo;
use app\lib\dicionario\StatusAssinatura;

class AssinaturaServices
{
    private PlanoTipo $plano;
    private Pessoa $pessoa;

    public function __construct(
        private string $token,
        private int $plano_tipo_id
    ) {
        $this->plano =  PlanoTipo::findOne($plano_tipo_id);
        $user = Yii::$app->user->identity;
        $this->pessoa = $user->pessoa;
    }

    public function save()
    {
        $this->criaAssinaturaAPI();
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

            //throw new PagamentoException("A assinatura na api do mercado livre não foi criado!");
        }
        print_r($resp);
        exit();
        return $resp['id'];
    }

    private function savaAssinaturaDB()
    {
    }
}
