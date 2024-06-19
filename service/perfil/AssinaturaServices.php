<?php

namespace app\service\perfil;

use Yii;
use app\lib\PagamentoException;
use app\models\admin\PlanoTipo;

class AssinaturaServices
{
    private PlanoTipo $plano;

    public function __construct(
        private string $token,
        private int $plano_tipo_id
    ) {
        $this->plano =  PlanoTipo::findOne($plano_tipo_id);
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
                                        "currency_id": "' . $planoDescricao->currency_id . '"
                                    },
                                    "back_url": "' . $planoDescricao->back_url . '",   
                                    "card_token_id":"' . $this->token . '"
                                    }';

        echo $json;
        exit();

        curl_setopt_array($curl, array(
            CURLOPT_URL => Yii::$app->mercado_pago->url . 'preapproval',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => '{
                                    "auto_recurring": {
                                        "frequency": ' . $planoDescricao->frequencia . ',
                                        "frequency_type": "' . $planoDescricao->tipo_frequencia . '",
                                        "currency_id": "' . $planoDescricao->currency_id . '"
                                    },
                                    "back_url": "' . $planoDescricao->back_url . '",   
                                    "card_token_id":"' . $this->token . '"
                                    }',
            CURLOPT_HTTPHEADER => array(
                "Content-Type: application/json",
                "Authorization: Bearer " . Yii::$app->mercado_pago->token
            ),
        ));

        $response = curl_exec($curl);

        curl_close($curl);
        $resp = \json_decode($response, true);

        if (empty($resp['id'])) {
            throw new PagamentoException("A assinatura na api do mercado livre não foi criado!");
        }

        return $resp['id'];
    }

    private function savaAssinaturaDB()
    {
    }
}
