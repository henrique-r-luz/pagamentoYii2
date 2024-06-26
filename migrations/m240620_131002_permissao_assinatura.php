<?php

use yii\db\Migration;
use app\models\admin\permissao\TipoPermissao;

/**
 * Class m240620_131002_permissao_assinatura
 */
class m240620_131002_permissao_assinatura extends Migration
{
    /**
     * {@inheritdoc}
     */
    public function safeUp()
    {
        $objetoData = new \DateTime;
        $data = (int) $objetoData->getTimestamp();

        $this->insert('auth_item', [
            'name' => '/perfil/assinatura-cliente/*',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/conteudo-ouro/*',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/conteudo-prata/*',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->batchInsert('auth_item_child', ['parent', 'child'], [
            ['parent' => 'prata', 'child' => '/perfil/assinatura-cliente/*'],
            ['parent' => 'ouro', 'child' => '/perfil/assinatura-cliente/*'],
            ['parent' => 'padrao', 'child' => '/perfil/assinatura-cliente/*'],
            ['parent' => 'prata', 'child' => '/conteudo-prata/*'],
            ['parent' => 'ouro', 'child' => '/conteudo-prata/*'],
            ['parent' => 'ouro', 'child' => '/conteudo-ouro/*']

        ]);

        $this->alterColumn('assinatura', 'data_inicio', 'TIMESTAMP NOT NULL');
        $this->alterColumn('assinatura', 'data_fim', 'TIMESTAMP');
        $this->addColumn('assinatura', 'created_at', 'INTEGER');
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {
        $this->alterColumn('assinatura', 'data_inicio', 'date NOT NULL');
        $this->alterColumn('assinatura', 'data_fim', 'date');
        $this->dropColumn('assinatura', 'created_at');

        $this->delete('auth_item_child', [
            'child' => '/perfil/assinatura-cliente/*',
        ]);


        $this->delete('auth_item', [
            'name' => '/perfil/assinatura-cliente/*'
        ]);

        $this->delete('auth_item_child', [
            'child' => '/conteudo-prata/*',
        ]);

        $this->delete('auth_item', [
            'name' => '/conteudo-prata/*'
        ]);

        $this->delete('auth_item', [
            'name' => '/conteudo-ouro/*'
        ]);


        $this->delete('auth_item_child', [
            'child' => '/conteudo-ouro/*',
        ]);
    }
}
