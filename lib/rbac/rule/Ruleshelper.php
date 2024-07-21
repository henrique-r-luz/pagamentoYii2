<?php

namespace app\lib\rbac\rule;

use app\models\admin\Assinatura;

class Ruleshelper
{

    public static function userCancelar($user_id, $params)
    {

        if (!isset($params['get']['id'])) {
            return false;
        }
        if (Assinatura::find()->where(['user_id' => $user_id])
            ->andWhere(['id' => $params['get']['id']])->exists()
        ) {
            return true;
        }
        return false;
    }
}
