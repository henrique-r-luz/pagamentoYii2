<?php

use yii\db\Migration;
use app\models\admin\User;
use app\models\admin\Pessoa;

/**
 * Class m240606_124216_add_user_admin
 */
class m240606_124216_add_user_admin extends Migration
{
    /**
     * {@inheritdoc}
     */
    public function safeUp()
    {

        $objetoData = new \DateTime;
        $data = (int) $objetoData->getTimestamp();

        $this->createIndex(
            'idx-unique-username',
            'user',
            [
                'username',
            ],
            true
        );

        $this->createIndex(
            'idx-unique-auth-assignment-user',
            'auth_assignment',
            [
                'user_id',
            ],
            true
        );

        $this->alterColumn('user', 'authkey', 'text');

        $passwordHash = Yii::$app->security->generatePasswordHash('admin');

        $this->insert('pessoa', [
            'nome' => 'Admim',
            'cpf' => '90042297010',
            'email' => 'admin@pagamentoYii.com'
        ]);
        // Inserir o usuário admin
        $this->insert('user', [
            'username' => 'admin',
            'password' => $passwordHash,
            'pessoa_id' => Pessoa::find()->where(['cpf' => '90042297010'])->one()->id
        ]);

        $this->insert('auth_assignment', [
            'item_name' => 'admin',
            'user_id' => '1',
            'created_at' => $data,
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {

        $this->delete('auth_assignment', [
            'item_name' => 'admin',
        ]);

        $this->delete('user', [
            'username' => 'admin',
        ]);

        $this->delete('pessoa', [
            'cpf' => '90042297010',
        ]);

        $this->dropIndex('idx-unique-username', 'user');
        $this->dropIndex('idx-unique-auth-assignment-user', 'auth_assignment');
    }
}
