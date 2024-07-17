<?php

use yii\db\Migration;
use app\lib\dicionario\Papeis;

/**
 * Class m240717_142446_cria_planos
 */
class m240717_142446_cria_planos extends Migration
{
    /**
     * {@inheritdoc}
     */
    public function safeUp()
    {
        $this->insert(
            'plano_tipo',
            [
                'nome' => 'Plano Ouro',
                'auth_item_name' => Papeis::OURO
            ]
        );

        $this->insert(
            'plano_tipo',
            [
                'nome' => 'Plano Prata',
                'auth_item_name' => Papeis::PRATA
            ]
        );
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {
        $this->delete(
            'plano_tipo',
            [
                'auth_item_name' => Papeis::OURO
            ]
        );

        $this->delete(
            'plano_tipo',
            [
                'auth_item_name' => Papeis::PRATA
            ]
        );
    }

    /*
    // Use up()/down() to run migration code without a transaction.
    public function up()
    {

    }

    public function down()
    {
        echo "m240717_142446_cria_planos cannot be reverted.\n";

        return false;
    }
    */
}
