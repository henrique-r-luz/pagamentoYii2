<?php

namespace app\lib\rbac\rule;

use Yii;
use yii\rbac\Rule;
use app\lib\rbac\rule\RulesDicionario;

class PrataRule extends Rule
{
    public $name  =  "prataRule";
    private int $user_id;
    private array $params;
    public function execute($user, $item, $params)
    {
        $this->params = $params;
        $this->user_id = $user;
        if (empty($params)) {
            return true;
        }

        if (Yii::$app->controller->id == RulesDicionario::PERFIL_USER && Yii::$app->controller->action->id == 'editar') {
            return $this->perfilUserEditar();
        }

        if (Yii::$app->controller->id == RulesDicionario::PERFIL_USER && Yii::$app->controller->action->id == 'cancelar') {
            return $this->perfilUserCancelar();
        }

        if (Yii::$app->controller->id == RulesDicionario::ASSINATURA_CLIENTE && Yii::$app->controller->action->id == 'seleciona-plano') {
            return $this->assinaturaClienteSelecionaPlano();
        }

        if (Yii::$app->controller->id == RulesDicionario::ASSINATURA_CLIENTE && Yii::$app->controller->action->id == 'create') {
            return $this->assinaturaClienteCreate();
        }

        if (Yii::$app->controller->id == RulesDicionario::ASSINATURA_CLIENTE && Yii::$app->controller->action->id == 'pagamento') {
            return $this->assinaturaClientePagamento();
        }
        return false;
    }

    private function perfilUserEditar()
    {
        return true;
    }

    private function  perfilUserCancelar()
    {
        return  Ruleshelper::userCancelar($this->user_id, $this->params);
    }

    private function assinaturaClienteSelecionaPlano()
    {
        return true;
    }

    private function assinaturaClienteCreate()
    {
        return true;
    }

    private function assinaturaClientePagamento()
    {
        return true;
    }
}
