<?php

namespace app\lib\rbac;

use Yii;
use yii\filters\AccessControl;

class AcessControlPagamento extends AccessControl
{
    public $allowRotas = [];
    public function beforeAction($action)
    {
        /*echo Yii::$app->controller->route;
        exit();
        return true;*/

        $user = $this->user;
        /**
         * páginas públicas
         */
        foreach ($this->allowRotas as $rota) {
            if ($rota == '/' . Yii::$app->controller->route) {
                return true;
            }
        }
        /**
         * grupo administrador tem acesso inrestrito
         */
        if (Yii::$app->user->can('admin')) {
            return true;
        }
        $this->denyAccess($user);
        return false;
    }
}
