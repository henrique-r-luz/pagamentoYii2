<?php

use app\lib\dicionario\StatusAssinatura;
use yii\db\Migration;

/**
 * Class m240619_131147_estrutura_assinatura
 */
class m240619_131147_estrutura_assinatura extends Migration
{
    /**
     * {@inheritdoc}
     */
    public function safeUp()
    {
        $this->addColumn('assinatura', 'id_api_assinatura', $this->text());
        $this->addColumn('assinatura', 'status', $this->text());
        $this->execute("CREATE UNIQUE INDEX unique_user_status ON assinatura (status, user_id) WHERE status = '" . StatusAssinatura::AUTHORIZED . "'");
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {
        $this->execute('DROP INDEX IF EXISTS unique_user_status');
        $this->dropColumn('assinatura', 'id_api_assinatura');
        $this->dropColumn('assinatura', 'status');
    }
}
