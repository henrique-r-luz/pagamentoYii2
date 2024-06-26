<?php

namespace app\lib\helper;

use Yii;
use app\lib\PagamentoException;


class RequisicaoApi
{

    public function __construct(
        private string $url,
        private string $metodo
    ) {
    }

    public function enviaJson($json)
    {
        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL => $this->url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => $this->metodo,
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

            throw new PagamentoException("Erro na interação com a API Mercado: " . $resp['message'] ?? 'Erro não identificado');
        }
        return $resp['id'];
    }
}
