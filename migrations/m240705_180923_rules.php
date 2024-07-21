<?php

use yii\db\Migration;
use app\lib\rbac\rule\OuroRule;
use app\lib\rbac\rule\PrataRule;
use app\lib\rbac\rule\PadraoRule;

/**
 * Class m240705_180923_rules
 */
class m240705_180923_rules extends Migration
{
    /**
     * {@inheritdoc}
     */
    public function safeUp()
    {
        $auth = Yii::$app->authManager;

        // Adicionar a regra ao AuthManager
        $rule = new PadraoRule();
        $auth->add($rule);

        /**
         * permissão type tem que ser 2;
         */
        $authItem = $auth->getPermission('padrao');
        // $authItem = AuthItem::find()->where(['name' => Papeis::OURO])->one();
        $authItem->ruleName = $rule->name;
        $auth->update('padrao', $authItem);


        $rule = new OuroRule();
        $auth->add($rule);

        /**
         * permissão type tem que ser 2;
         */
        $authItem = $auth->getPermission('ouro');
        // $authItem = AuthItem::find()->where(['name' => Papeis::OURO])->one();
        $authItem->ruleName = $rule->name;
        $auth->update('ouro', $authItem);



        $rule = new PrataRule();
        $auth->add($rule);

        /**
         * permissão type tem que ser 2;
         */
        $authItem = $auth->getPermission('prata');
        // $authItem = AuthItem::find()->where(['name' => Papeis::OURO])->one();
        $authItem->ruleName = $rule->name;
        $auth->update('prata', $authItem);
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {
        $auth = Yii::$app->authManager;

        // Recuperar a regra
        $rule = $auth->getRule('padraoRule');
        if ($rule) {
            // Remover a regra
            $auth->remove($rule);
        }

        $rule = $auth->getRule('ouroRule');
        if ($rule) {
            // Remover a regra
            $auth->remove($rule);
        }


        $rule = $auth->getRule('prataRule');
        if ($rule) {
            // Remover a regra
            $auth->remove($rule);
        }
    }
}
