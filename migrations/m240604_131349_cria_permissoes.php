<?php

use yii\db\Migration;
use app\lib\dicionario\Papeis;
use app\models\admin\permissao\TipoPermissao;

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
            'name' => '/site/index',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/gratuito',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/pago',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/prata',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);


        $this->insert('auth_item', [
            'name' => '/ouro',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/pessoa/*',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/user/*',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/plano-tipo/*',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/plano-descricao/*',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/forma-pagamento/*',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => '/admin/assinatura/*',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        /**
         * papeis
         */

        $this->insert('auth_item', [
            'name' => 'admin',
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['papeis']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);



        /**
         * planos
         */
        $this->insert('auth_item', [
            'name' => Papeis::PADRAO,
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['plano']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);



        $this->insert('auth_item', [
            'name' => Papeis::PRATA,
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['plano']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->insert('auth_item', [
            'name' => Papeis::OURO,
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['plano']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);


        $this->batchInsert('auth_item_child', ['parent', 'child'], [
            ['parent' => Papeis::PADRAO, 'child' => '/gratuito'],
            ['parent' => Papeis::PADRAO, 'child' => '/site/index'],

            ['parent' => Papeis::PRATA, 'child' => '/gratuito'],
            ['parent' => Papeis::PRATA, 'child' => '/pago'],
            ['parent' => Papeis::PRATA, 'child' => '/prata'],
            ['parent' => Papeis::PRATA, 'child' => '/site/index'],

            ['parent' => Papeis::OURO, 'child' => '/gratuito'],
            ['parent' => Papeis::OURO, 'child' => '/pago'],
            ['parent' => Papeis::OURO, 'child' => '/prata'],
            ['parent' => Papeis::OURO, 'child' => '/ouro'],
            ['parent' => Papeis::OURO, 'child' => '/site/index'],

        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {


        $this->delete('auth_item_child', [
            'parent' => Papeis::PADRAO,
        ]);

        $this->delete('auth_item_child', [
            'parent' => Papeis::OURO,
        ]);

        $this->delete('auth_item_child', [
            'parent' => Papeis::PADRAO,
        ]);


        $this->delete('auth_item', [
            'name' => Papeis::PADRAO,
        ]);


        $this->delete('auth_item', [
            'name' => Papeis::PADRAO,
        ]);

        $this->delete('auth_item', [
            'name' => Papeis::OURO,
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
            'name' => '/site/index'
        ]);

        $this->delete('auth_item', [
            'name' => 'admin',
        ]);
    }
}
