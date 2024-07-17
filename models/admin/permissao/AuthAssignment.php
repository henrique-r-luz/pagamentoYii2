<?php

namespace app\models\admin\permissao;

use Yii;
use app\models\admin\permissao\TipoPermissao;

/**
 * This is the model class for table "auth_assignment".
 *
 * @property string $item_name
 * @property string $user_id
 * @property int|null $created_at
 *
 * @property AuthItem $itemName
 */
class AuthAssignment extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'auth_assignment';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['item_name', 'user_id'], 'required'],
            [['created_at'], 'default', 'value' => null],
            [['created_at'], 'integer'],
            [['item_name', 'user_id'], 'string', 'max' => 64],
            [['item_name', 'user_id'], 'unique', 'targetAttribute' => ['item_name', 'user_id']],
            [['item_name'], 'exist', 'skipOnError' => true, 'targetClass' => AuthItem::class, 'targetAttribute' => ['item_name' => 'name']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'item_name' => 'Item Name',
            'user_id' => 'User ID',
            'created_at' => 'Created At',
        ];
    }

    /**
     * Gets query for [[ItemName]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getItemName()
    {
        return $this->hasOne(AuthItem::class, ['name' => 'item_name']);
    }


    public static  function permissoesUser()
    {
        $query =  self::find()
            ->select([
                'auth_item_child.child as name'
            ])
            ->innerJoin('auth_item', 'auth_item.name = auth_assignment.item_name')
            ->innerJoin('auth_item_child', '"auth_item_child"."parent" = auth_item.name')
            ->innerJoin('auth_item as auth_item_filhos', 'auth_item_filhos.name = auth_item_child.child')
            ->where(['user_id' => strval(Yii::$app->user->id)])
            ->andWhere(['auth_item_filhos.description' => TipoPermissao::ROTA])->distinct();

        if (Yii::$app->user->can('admin')) {
            $query =  AuthItem::find()
                ->select([
                    'name'
                ])
                ->andWhere(['description' => TipoPermissao::ROTA])->distinct();
        }

        $listaRotas = array_keys($query->asArray()
            ->indexBy(['name'])->all());
        foreach ($listaRotas as $i => $rota) {
            $listaRotas[$i] = str_replace('/*', "", $rota);
        }

        return $listaRotas;
    }
}
