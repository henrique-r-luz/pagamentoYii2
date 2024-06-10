<?php

use yii\db\Migration;
use app\models\admin\permissao\TipoPermissao;

/**
 * Class m240610_144455_perfil
 */
class m240610_144455_perfil extends Migration
{
    /**
     * {@inheritdoc}
     */
    public function safeUp()
    {
        $objetoData = new \DateTime;
        $data = (int) $objetoData->getTimestamp();

        $this->insert('auth_item', [
            'name' => '/perfil/perfil-user/*',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->batchInsert('auth_item_child', ['parent', 'child'], [
            ['parent' => 'prata', 'child' => '/perfil/perfil-user/*'],
            ['parent' => 'padrao', 'child' => '/perfil/perfil-user/*'],
            ['parent' => 'ouro', 'child' => '/perfil/perfil-user/*'],


        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {
        $this->delete('auth_item_child', ['child' => '/perfil/perfil-user/*']);
        $this->delete('auth_item', [
            'name' => '/perfil/perfil-user/*'
        ]);
    }
}
