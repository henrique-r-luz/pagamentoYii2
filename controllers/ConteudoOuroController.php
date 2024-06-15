<?php

namespace app\controllers;

use yii\web\Controller;

class ConteudoOuroController extends Controller
{
    public function actionIndex()
    {
        return $this->render('index');
    }
}
