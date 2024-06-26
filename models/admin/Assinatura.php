<?php

namespace app\models\admin;

use Yii;
use yii\db\ActiveRecord;

/**
 * This is the model class for table "assinatura".
 *
 * @property int $id
 * @property int $plano_tipo_id
 * @property string $data_inicio
 * @property string|null $data_fim
 *
 * @property Pessoa $planoTipo
 */
class Assinatura extends ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'assinatura';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['plano_tipo_id', 'data_inicio', 'created_at'], 'required'],
            [['plano_tipo_id'], 'default', 'value' => null],
            [['plano_tipo_id', 'user_id', 'created_at'], 'integer'],
            [['data_inicio', 'data_fim'], 'safe'],
            [['status', 'id_api_assinatura'], 'string'],
            [['plano_tipo_id'], 'exist', 'skipOnError' => true, 'targetClass' => PlanoTipo::class, 'targetAttribute' => ['plano_tipo_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'plano_tipo_id' => 'Plano Tipo ID',
            'data_inicio' => 'Data Inicio',
            'data_fim' => 'Data Fim',
            'status' => 'Status',
            'id_api_assinatura' => 'Api Id'
        ];
    }

    /**
     * Gets query for [[PlanoTipo]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getPlanoTipo()
    {
        return $this->hasOne(PlanoTipo::class, ['id' => 'plano_tipo_id']);
    }

    public function getUser()
    {
        return $this->hasOne(User::class, ['id' => 'user_id']);
    }
}
