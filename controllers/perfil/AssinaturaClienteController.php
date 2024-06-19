<?php

namespace app\controllers\perfil;


use Yii;

use yii\web\Response;
use yii\web\Controller;
use app\models\perfil\SelecaoPlano;
use app\service\perfil\AssinaturaServices;
use app\lib\behaviorController\DisableCsrfBehavior;
use app\models\admin\PlanoTipo;

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


    public function actionSelecionaPlano()
    {
        $selecaoPlano = new SelecaoPlano();
        if ($selecaoPlano->load($this->request->post())) {
            return $this->redirect(['create', 'plano_id' => $selecaoPlano->plano_id]);
        }
        return $this->render('seleciona-plano', [
            'model' => $selecaoPlano
        ]);
    }

    public function actionCreate(int $plano_id)
    {
        $planoTipo = PlanoTipo::findOne($plano_id);
        return $this->render('create', [
            'planoTipo' => $planoTipo
        ]);
    }


    public function actionPagamento()
    {
        $request = Yii::$app->request;
        $data = $request->getRawBody(); // Isso retorna um array com os dados JSON
        $resp = \json_decode($data, true);
        print_r($resp);
        exit();
        $assinaturaServices = new AssinaturaServices($resp['token'], $resp['plano_id']);

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
