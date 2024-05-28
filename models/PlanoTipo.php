<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "plano_tipo".
 *
 * @property int $id
 * @property string $nome
 *
 * @property PlanoDescricao[] $planoDescricaos
 */
class PlanoTipo extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'plano_tipo';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['nome'], 'required'],
            [['nome'], 'string'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'nome' => 'Nome',
        ];
    }

    /**
     * Gets query for [[PlanoDescricaos]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getPlanoDescricaos()
    {
        return $this->hasMany(PlanoDescricao::class, ['plano_tipo_id' => 'id']);
    }
}
