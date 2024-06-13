<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "arquivo".
 *
 * @property int $id
 * @property string $hash
 * @property string $model
 * @property int $model_id
 * @property string $path
 * @property string $mimetype
 * @property float|null $largura
 * @property float|null $altura
 */
class Arquivo extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'arquivo';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['hash', 'model', 'model_id', 'mimetype'], 'required'],
            [['hash', 'model', 'path', 'mimetype'], 'string'],
            [['model_id'], 'default', 'value' => null],
            [['model_id'], 'integer'],
            [['largura', 'altura'], 'number'],
            [['model', 'model_id', 'hash'], 'unique', 'targetAttribute' => ['model', 'model_id', 'hash']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'hash' => 'Hash',
            'model' => 'Model',
            'model_id' => 'Model ID',
            'path' => 'Path',
            'mimetype' => 'Mimetype',
            'largura' => 'Largura',
            'altura' => 'Altura',
        ];
    }
}
