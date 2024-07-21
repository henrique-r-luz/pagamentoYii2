<?php

use yii\db\Migration;
use app\models\admin\PlanoTipo;
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
            'type' => 2,
            'description' => TipoPermissao::DESCRICAO[TipoPermissao::TYPE['rota']],
            'created_at' => $data,
            'updated_at' => $data,
        ]);

        $this->batchInsert('auth_item_child', ['parent', 'child'], [
            ['parent' => 'prata', 'child' => '/perfil/perfil-user/*'],
            ['parent' => 'padrao', 'child' => '/perfil/perfil-user/*'],
            ['parent' => 'ouro', 'child' => '/perfil/perfil-user/*'],
        ]);

        $this->createTable(
            'arquivo',
            [
                'id' => $this->primaryKey(),
                'hash' => $this->text()->notNull(),
                'model' => $this->text()->notNull(),
                'model_id' => $this->integer()->notNull(),
                'path' => $this->text()->notNull(),
                'mimetype' => $this->text()->notNull(),
                'largura' => $this->float(),
                'altura' => $this->float(),
                'created_at' => $this->integer()->notNull()

            ]
        );

        $this->createIndex(
            'idx-model-arquivo',
            'arquivo',
            [
                'model',
            ],
        );

        $this->createIndex(
            'idx-model-id-arquivo',
            'arquivo',
            [
                'model_id',
            ],
        );

        $this->createIndex(
            'unique-model-hash-arquivo',
            'arquivo',
            [
                'model',
                'model_id',
                'hash'

            ],
            true
        );

        $this->insert('plano_tipo', [
            'nome' => PlanoTipo::PLANO_PADRAO,
            'auth_item_name' => 'padrao'
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {
        $this->delete('plano_tipo', [
            'nome' => PlanoTipo::PLANO_PADRAO
        ]);

        $this->delete('auth_item_child', ['child' => '/perfil/perfil-user/*']);
        $this->delete('auth_item', [
            'name' => '/perfil/perfil-user/*'
        ]);
        $this->dropTable('arquivo');
    }
}
