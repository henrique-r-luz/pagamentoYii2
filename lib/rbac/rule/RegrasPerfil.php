<?php

namespace app\lib\rbac\rule;


class RegrasPerfil
{

    public function __construct(
        private $user,
        private $item,
        private $params
    ) {
    }

    public function verifica()
    {
    }
    // Yii::$app->controller->id
    //Yii::$app->controller->action->id
}
