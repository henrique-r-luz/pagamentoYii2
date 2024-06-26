<?php

namespace app\service\perfil;

use Yii;
use app\lib\helper\RequisicaoApi;
use app\lib\dicionario\StatusAssinatura;

class ReverteAssinaturaService
{

    public array $idAssinaturasCriado = [];
    public function __construct()
    {
    }


    public function addAssinaturasCriadas($id)
    {
        $this->idAssinaturasCriado[] = $id;
    }


    public function corrige()
    {

        foreach ($this->idAssinaturasCriado as $i => $criada) {
            $this->cancelaAssinaturaAPI($criada);
            // unset($this->idAssinaturasCriado[$i]);
        }
    }


    private function cancelaAssinaturaAPI($id_api)
    {
        $json  = '{
            "status":"' . StatusAssinatura::CANCELLED . '"
          }';
        $requisicaoApi = new RequisicaoApi(Yii::$app->mercado_pago->url . 'preapproval/' . $id_api, 'PUT');
        $requisicaoApi->enviaJson($json);
    }
}
