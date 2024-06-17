<?php

namespace app\controllers\perfil;


use Yii;

use yii\web\Response;
use yii\web\Controller;
use app\lib\behaviorController\DisableCsrfBehavior;

class AssinaturaClienteController extends Controller
{

    public function behaviors()
    {
        return [
            'disableCsrf' => [
                'class' => DisableCsrfBehavior::class,
                'actions' => ['pagamento'], // Lista das ações para desativar CSRF
            ],
        ];
    }

    public function actionCreate()
    {
        return $this->render('create', []);
    }


    public function actionPagamento()
    {

        echo 'boraaa';
        /* MercadoPagoConfig::setAccessToken(Yii::$app->mercado_pago->token);

        $request_options = new RequestOptions();
        $request_options->setCustomHeaders(["X-Idempotency-Key: aabb"]);*/
        // Yii::$app->response->format = Response::FORMAT_JSON;
        //MercadoPagoConfig::setAccessToken(Yii::$app->mercado_pago->token);
        /*echo '<pre>';
        print_r($this->request->post());
        exit();*/
    }
}
