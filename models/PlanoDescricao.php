<?php

namespace app\models;

use Yii;
use app\models\admin\PlanoTipo;

/**
 * This is the model class for table "plano_descricao".
 *
 * @property int $id
 * @property int $plano_tipo_id
 * @property string $auth_item_name
 * @property int $frequencia
 * @property int $tipo_frequencia
 * @property int $repeticao
 * @property string $back_url
 * @property int $dia_compra
 * @property int $dia_compra_proporcional
 * @property float $valor_plano
 * @property string $currency_id
 * @property string $descricao_fatura
 *
 * @property AuthItem $authItemName
 * @property FormaPagamento[] $formaPagamentos
 * @property ItensFormaPagamento[] $itensFormaPagamentos
 * @property PlanoTipo $planoTipo
 */
class PlanoDescricao extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'plano_descricao';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['plano_tipo_id', 'auth_item_name', 'frequencia', 'tipo_frequencia', 'repeticao', 'back_url', 'dia_compra', 'dia_compra_proporcional', 'valor_plano', 'currency_id', 'descricao_fatura'], 'required'],
            [['plano_tipo_id', 'frequencia', 'tipo_frequencia', 'repeticao', 'dia_compra', 'dia_compra_proporcional'], 'default', 'value' => null],
            [['plano_tipo_id', 'frequencia', 'tipo_frequencia', 'repeticao', 'dia_compra', 'dia_compra_proporcional'], 'integer'],
            [['auth_item_name', 'back_url', 'currency_id', 'descricao_fatura'], 'string'],
            [['valor_plano'], 'number'],
            [['auth_item_name'], 'exist', 'skipOnError' => true, 'targetClass' => AuthItem::class, 'targetAttribute' => ['auth_item_name' => 'name']],
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
            'auth_item_name' => 'Auth Item Name',
            'frequencia' => 'Frequencia',
            'tipo_frequencia' => 'Tipo Frequencia',
            'repeticao' => 'Repeticao',
            'back_url' => 'Back Url',
            'dia_compra' => 'Dia Compra',
            'dia_compra_proporcional' => 'Dia Compra Proporcional',
            'valor_plano' => 'Valor Plano',
            'currency_id' => 'Currency ID',
            'descricao_fatura' => 'Descricao Fatura',
        ];
    }

    /**
     * Gets query for [[AuthItemName]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getAuthItemName()
    {
        return $this->hasOne(AuthItem::class, ['name' => 'auth_item_name']);
    }

    /**
     * Gets query for [[FormaPagamentos]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getFormaPagamentos()
    {
        return $this->hasMany(FormaPagamento::class, ['id' => 'forma_pagamento_id'])->viaTable('itens_forma_pagamento', ['plano_descricao_id' => 'id']);
    }

    /**
     * Gets query for [[ItensFormaPagamentos]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getItensFormaPagamentos()
    {
        return $this->hasMany(ItensFormaPagamento::class, ['plano_descricao_id' => 'id']);
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
}
