<?php

use yii\db\Migration;

/**
 * Class m240528_013456_criar_tabelas_inicias
 */
class m240528_013456_criar_tabelas_inicias extends Migration
{
    /**
     * {@inheritdoc}
     */
    public function safeUp()
    {

        $this->createTable(
            'plano_tipo',
            [
                'id' => $this->primaryKey(),
                'nome' => $this->text()->notNull(),
                'auth_item_name' => $this->text()->notNull(),
            ]
        );


        $this->addForeignKey(
            'auth_item_name_plano_tipo_fk',
            'plano_tipo',
            'auth_item_name',
            'auth_item',
            'name',
            'CASCADE'
        );


        $this->createTable(
            'pessoa',
            [
                'id' => $this->primaryKey(),
                'nome' => $this->text()->notNull(),
                'cpf' => $this->string(11)->notNull(),
                'email' => $this->text()->notNull(),
            ]
        );

        $this->createIndex(
            'idx-unique-pessoa-cpf',
            'pessoa',
            [
                'cpf',
            ],
            true
        );

        $this->createIndex(
            'idx-unique-pessoa-email',
            'pessoa',
            [
                'email',
            ],
            true
        );


        $this->createTable(
            'user',
            [
                'id' => $this->primaryKey(),
                'username' => $this->text()->notNull(),
                'password' => $this->text()->notNull(),
                'authkey' => $this->text()->notNull(),
                'pessoa_id' => $this->integer()->notNull(),

            ]
        );

        $this->createTable(
            'assinatura',
            [
                'id' => $this->primaryKey(),
                'user_id' => $this->integer()->notNull(),
                'plano_tipo_id' => $this->integer()->notNull(),
                'data_inicio' => $this->date()->notNull(),
                'data_fim' => $this->date(),

            ]
        );

        $this->addForeignKey(
            'plano_tipo_assinatura_fk',
            'assinatura',
            'plano_tipo_id',
            'plano_tipo',
            'id',
            'CASCADE'
        );


        $this->addForeignKey(
            'user_assinatura_fk',
            'assinatura',
            'user_id',
            'user',
            'id',
            'CASCADE'
        );


        $this->addForeignKey(
            'pessoa_user_fk',
            'user',
            'pessoa_id',
            'pessoa',
            'id',
            'CASCADE'
        );




        $this->createTable(
            'plano_descricao',
            [
                'id' => $this->primaryKey(),
                'plano_tipo_id' => $this->integer()->notNull(),
                'frequencia' => $this->integer()->notNull(),
                'tipo_frequencia' => $this->text()->notNull(),
                'repeticao' => $this->integer()->notNull(),
                'back_url' => $this->text()->notNull(),
                'dia_compra' => $this->integer()->notNull(),
                'dia_compra_proporcional' => $this->boolean()->notNull(),
                'valor_plano' => $this->decimal(10, 2)->notNull(),
                'currency_id' => $this->text()->notNull(),
                'descricao_fatura' => $this->text()->notNull()
            ]
        );


        $this->addForeignKey(
            'plano_tipo_plano_descricao_fk',
            'plano_descricao',
            'plano_tipo_id',
            'plano_tipo',
            'id',
            'CASCADE'
        );

        $this->createTable(
            'itens_forma_pagamento',
            [
                'id' => $this->primaryKey(),
                'plano_descricao_id' => $this->integer()->notNull(),
                'forma_pagamento_id' => $this->integer()->notNull(),
            ]
        );

        $this->createIndex(
            'idx-unique-tipo-meio-pagamento',
            'itens_forma_pagamento',
            [
                'plano_descricao_id',
                'forma_pagamento_id'
            ],
            true
        );

        $this->addForeignKey(
            'itens_forma_pagamento_plano_descricao_fk',
            'itens_forma_pagamento',
            'plano_descricao_id',
            'plano_descricao',
            'id',
            'CASCADE'
        );


        $this->createTable(
            'forma_pagamento',
            [
                'id' => $this->primaryKey(),
                'tipo_pagamento' => $this->text()->notNull(),
                'meio_pagamento' => $this->text()->notNull(),
            ]
        );


        $this->addForeignKey(
            'itens_forma_pagamento_forma_pagamento_fk',
            'itens_forma_pagamento',
            'forma_pagamento_id',
            'forma_pagamento',
            'id',
            'CASCADE'
        );
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {

        $this->dropTable(
            'assinatura'
        );

        $this->dropTable(
            'user'
        );

        $this->dropTable(
            'pessoa'
        );


        $this->dropTable(
            'itens_forma_pagamento'
        );


        $this->dropTable(
            'plano_descricao'
        );

        $this->dropTable(
            'forma_pagamento',
        );

        $this->dropTable(
            'plano_tipo',
        );
    }
}
