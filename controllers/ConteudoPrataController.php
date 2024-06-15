<?php

namespace app\controllers;

use yii\web\Controller;

class ConteudoPrataController extends Controller
{
    public function actionIndex()
    {
        return $this->render('index');
    }
}
