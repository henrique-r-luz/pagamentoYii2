<?php

namespace app\lib\rbac\rule;

use yii\rbac\Rule;
use yii\web\ForbiddenHttpException;

class OuroRule extends Rule
{

    public $name  =  "ouroRule";

    public function execute($user, $item, $params)
    {
        // $this->denyAccess($user);
        //throw new ForbiddenHttpException('Você não tem permissão para acessar esta página.');
    }
}
