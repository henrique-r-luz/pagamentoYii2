<?php

namespace app\lib\rbac\rule;

use app\models\admin\Assinatura;
use Yii;
use yii\rbac\Rule;

class PadraoRule extends Rule
{
    public $name  =  "padraoRule";
    const PERFIL_USER = 'perfil/perfil-user';
    private int $user_id;
    private array $params;
    public function execute($user, $item, $params)
    {
        $this->params = $params;
        $this->user_id = $user;
        if (empty($params)) {
            return true;
        }

        if (Yii::$app->controller->id == self::PERFIL_USER && Yii::$app->controller->action->id == 'editar') {
            return $this->perfilUserEditar();
        }

        if (Yii::$app->controller->id == self::PERFIL_USER && Yii::$app->controller->action->id == 'cancelar') {
            return $this->perfilUserCancelar();
        }
        return false;
    }

    public function perfilUserEditar()
    {
        return true;
    }

    public function  perfilUserCancelar()
    {
        if (!isset($this->params['get']['id'])) {
            return false;
        }
        if (Assinatura::find()->where(['user_id' => $this->user_id])
            ->andWhere(['id' => $this->params['get']['id']])->exists()
        ) {
            return true;
        }
        return false;
    }
}
