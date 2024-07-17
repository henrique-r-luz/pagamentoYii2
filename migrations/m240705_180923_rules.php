<?php

use yii\db\Migration;
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
    }
}
