<?php

use app\models\admin\TipoPermissao;
use yii\db\Migration;

/**
 * Class m240604_131349_cria_permissoes
 */
class m240604_131349_cria_permissoes extends Migration
{
    /**
     * {@inheritdoc}
     */
    public function safeUp()
    {
        $objetoData = new \DateTime;
        $data = (int) $objetoData->getTimestamp();
        /**
         * rotas
         */
        $this->insert('auth_item', [
            'name' => '/gratuito',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/pago',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/prata',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);


        $this->insert('auth_item', [
            'name' => '/ouro',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/pessoa/*',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/user/*',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/plano-tipo/*',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/plano-descricao/*',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/forma-pagamento/*',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/assinatura/*',
            'type' => TipoPermissao::TYPE['rota'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        /**
         * papeis
         */

        $this->insert('auth_item', [
            'name' => 'admin',
            'type' => TipoPermissao::TYPE['papeis'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['papeis']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);



        /**
         * planos
         */
        $this->insert('auth_item', [
            'name' => 'padrao',
            'type' => TipoPermissao::TYPE['plano'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['plano']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item_child', [
            'parent' => 'padrao',
            'child' => '/gratuito'
        ]);

        $this->insert('auth_item', [
            'name' => 'prata',
            'type' => TipoPermissao::TYPE['plano'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['plano']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => 'ouro',
            'type' => TipoPermissao::TYPE['plano'],
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['plano']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);


        $this->batchInsert('auth_item_child', ['parent', 'child'], [
            ['parent' => 'prata', 'child' => '/gratuito'],
            ['parent' => 'prata', 'child' => '/pago'],
            ['parent' => 'prata', 'child' => '/prata'],

            ['parent' => 'ouro', 'child' => '/gratuito'],
            ['parent' => 'ouro', 'child' => '/pago'],
            ['parent' => 'ouro', 'child' => '/prata'],
            ['parent' => 'ouro', 'child' => '/ouro'],

        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {


        $this->delete('auth_item_child', [
            'parent' => 'prata',
        ]);

        $this->delete('auth_item_child', [
            'parent' => 'ouro',
        ]);

        $this->delete('auth_item_child', [
            'parent' => 'padrao',
        ]);


        $this->delete('auth_item', [
            'name' => 'padrao',
        ]);


        $this->delete('auth_item', [
            'name' => 'prata',
        ]);

        $this->delete('auth_item', [
            'name' => 'ouro',
        ]);


        $this->delete('auth_item', [
            'name' => '/gratuito',
        ]);


        $this->delete('auth_item', [
            'name' => '/pago',
        ]);

        $this->delete('auth_item', [
            'name' => '/prata',
        ]);


        $this->delete('auth_item', [
            'name' => '/ouro',
        ]);

        $this->delete('auth_item', [
            'name' => '/admin/pessoa/*',
        ]);

        $this->delete('auth_item', [
            'name' => '/admin/user/*',
        ]);

        $this->delete('auth_item', [
            'name' => '/admin/plano-tipo/*',
        ]);

        $this->delete('auth_item', [
            'name' => '/admin/plano-descricao/*',
        ]);

        $this->delete('auth_item', [
            'name' => '/admin/forma-pagamento/*',
        ]);

        $this->delete('auth_item', [
            'name' => '/admin/assinatura/*',
        ]);

        $this->delete('auth_item', [
            'name' => 'admin',
        ]);
    }
}
