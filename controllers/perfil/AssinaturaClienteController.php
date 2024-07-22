<?php

namespace app\controllers\perfil;


use Yii;

use yii\web\Response;
use yii\web\Controller;
use app\lib\PagamentoException;
use app\models\admin\PlanoTipo;
use app\models\perfil\SelecaoPlano;
use app\service\perfil\AssinaturaServices;
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


    public function actionSelecionaPlano()
    {
        $selecaoPlano = new SelecaoPlano();
        if ($selecaoPlano->load($this->request->post()) && $selecaoPlano->validate()) {
            return $this->redirect(['create', 'plano_id' => $selecaoPlano->plano_id]);
        }
        return $this->render('seleciona-plano', [
            'model' => $selecaoPlano
        ]);
    }

    public function actionCreate(int $plano_id)
    {
        $planoTipo = PlanoTipo::findOne($plano_id);
        $user = Yii::$app->user->identity;
        $pessoa = $user->pessoa;
        return $this->render('create', [
            'planoTipo' => $planoTipo,
            'pessoa' => $pessoa
        ]);
    }


    public function actionPagamento()
    {
        \Yii::$app->response->format = Response::FORMAT_JSON;
        $resp = null;
        try {
            $request = Yii::$app->request;
            $data = $request->getRawBody(); // Isso retorna um array com os dados JSON
            $resp = \json_decode($data, true);
            //valida dados
            $user = Yii::$app->user->identity;
            if ($user->pessoa->email != $resp['payer']['email']) {
                Yii::$app->session->setFlash('danger', 'Erro ao criar assinatura: O email não é o mesmo que o cadastrado!');
                return false;
            }
            if ($user->pessoa->cpf != $resp['payer']['identification']['number']) {
                Yii::$app->session->setFlash('danger', 'Erro ao criar assinatura: O cpf não é o mesmo que o cadastrado!');
                return false;
            }
            $assinaturaServices = new AssinaturaServices($resp['token'], $resp['plano_id']);
            $resp = $assinaturaServices->save();
            Yii::$app->session->setFlash('success', 'Assinatura criada com sucesso!!');
        } catch (PagamentoException $e) {
            Yii::$app->session->setFlash('danger', 'Erro ao criar assinatura: ' . $e->getMessage() . '!!');
            $resp =  $e->getMessage();
        } finally {
            return $resp;
        }
    }
}
