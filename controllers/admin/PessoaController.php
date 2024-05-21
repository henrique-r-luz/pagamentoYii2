<?php

namespace app\controllers\admin;

use yii\web\Controller;

class PessoaController extends Controller
{

    public function actionIndex()
    {
        return $this->render('index');
    }
}
