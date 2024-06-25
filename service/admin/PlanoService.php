<?php

namespace app\service\admin;

use Yii;
use Exception;
use Throwable;
use GuzzleHttp\Client;
use GuzzleHttp\Middleware;
use GuzzleHttp\HandlerStack;
use app\lib\PagamentoException;
use app\models\admin\PlanoDescricao;

/**
 * use GuzzleHttp\Client;


 */

class PlanoService
{

    public function criaPlano(PlanoDescricao $planoDescricao)
    {
        try {
            $planoApiId = $this->salvaNaApi($planoDescricao);
            $this->salvaNoBanco($planoApiId, $planoDescricao);
            return true;
        } catch (PagamentoException $e) {
            throw new PagamentoException($e->getMessage());
        } catch (Throwable $e) {
            throw new PagamentoException("Ocorreu um erro inesperado!");
        }
    }

    private function salvaNaApi($planoDescricao)
    {


        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => Yii::$app->mercado_pago->url . 'preapproval_plan',
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
                                        "repetitions":' . $planoDescricao->repeticao . ',
                                        "billing_day": ' . $planoDescricao->dia_compra . ',
                                        "billing_day_proportional": ' . $planoDescricao->dia_compra_proporcional . ',
                                        "transaction_amount": ' . $planoDescricao->valor_plano . ',
                                        "currency_id": "' . $planoDescricao->currency_id . '"
                                    },
                                    "back_url": "' . $planoDescricao->back_url . '",
                                    
                                    "reason": "' . $planoDescricao->descricao_fatura . '"
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

            throw new PagamentoException("O plano na api do mercado livre não foi criado!");
        }

        return $resp['id'];
    }

    private function salvaNoBanco($planoApiId, $planoDescricao)
    {
        $planoDescricao->plano_api_id = $planoApiId;
        if (!$planoDescricao->save()) {

            throw new PagamentoException("Erro ao salvar a api no banco de dados ");
        }
    }

}
