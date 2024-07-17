<?php

namespace app\lib\rbac;

use Yii;
use yii\filters\AccessControl;

class AcessControlPagamento extends AccessControl
{
    public $allowRotas = [];
    public function beforeAction($action): bool
    {
        $param = [
            'post' => Yii::$app->request->post(),
            'get' => Yii::$app->request->get()
        ];
        if (empty(Yii::$app->request->post()) && empty(Yii::$app->request->get())) {
            $param = [];
        }

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


        if (Yii::$app->controller->id == 'default') {
            return true;
        }
        /**
         * verifica permissões controller
         */

        $pagina = ('/' . Yii::$app->controller->id);
        if (Yii::$app->authManager->checkAccess($user->id, $pagina, $param)) {

            return true;
        }

        $pagina = ('/' . Yii::$app->controller->id . '/*');
        if (Yii::$app->authManager->checkAccess($user->id, $pagina, $param)) {
            return true;
        }

        /**
         * permissão action
         */
        $pagina = ('/' . Yii::$app->controller->id . '/' . Yii::$app->controller->action->id);
        if (Yii::$app->authManager->checkAccess($user->id, $pagina, $param)) {
            return true;
        }

        $this->denyAccess($user);
        return false;
    }

    public static function permissaoMenu($user_id, $pagina)
    {
        if (Yii::$app->user->can('admin')) {
            return true;
        }

        if (Yii::$app->authManager->checkAccess($user_id, $pagina)) {
            return true;
        }
        if (Yii::$app->authManager->checkAccess($user_id, $pagina . '/*')) {
            return true;
        }
        return false;
    }
}
