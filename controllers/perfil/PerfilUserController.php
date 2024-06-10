<?php

namespace app\controllers\perfil;

use Yii;
use yii\web\Controller;
use yii\web\NotFoundHttpException;

class PerfilUserController extends Controller
{
    public function actionIndex()
    {
        if (Yii::$app->user->isGuest) {
            throw new NotFoundHttpException('O usuário não está logado');
        }
        $user = Yii::$app->user->identity;
        return $this->render('index', [
            //'model' => $model,
            'user' => $user
        ]);
    }
}
