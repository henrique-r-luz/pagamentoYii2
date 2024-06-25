<?php

namespace app\models\admin;

use Yii;
use yii\helpers\ArrayHelper;
use app\models\admin\permissao\AuthItem;

/**
 * This is the model class for table "plano_tipo".
 *
 * @property int $id
 * @property string $nome
 *
 * @property PlanoDescricao
 */
class PlanoTipo extends \yii\db\ActiveRecord
{
    const PLANO_PADRAO = "Plano Padrão";
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
            [['nome', 'auth_item_name'], 'required'],
            [['nome', 'auth_item_name'], 'string'],
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
            'auth_item_name' => 'Permissão'
        ];
    }

    /**
     * Gets query for [[PlanoDescricao]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getPlanoDescricao()
    {
        return $this->hasOne(PlanoDescricao::class, ['plano_tipo_id' => 'id']);
    }

    public function getPermissao()
    {
        return $this->hasMany(AuthItem::class, ['auth_item_name' => 'name']);
    }

    public static function listaPlano()
    {
        return ArrayHelper::map(self::find()->asArray()->all(), 'id', 'nome');
    }

    public static function listaPlanoComDescricao()
    {
        return ArrayHelper::map(self::find()
            ->innerJoinWith(['planoDescricao'])
            ->asArray()->all(), 'id', 'nome');
    }
}
