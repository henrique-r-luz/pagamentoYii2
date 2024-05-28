<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "itens_forma_pagamento".
 *
 * @property int $id
 * @property int $plano_descricao_id
 * @property int $forma_pagamento_id
 *
 * @property FormaPagamento $formaPagamento
 * @property PlanoDescricao $planoDescricao
 */
class ItensFormaPagamento extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'itens_forma_pagamento';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['plano_descricao_id', 'forma_pagamento_id'], 'required'],
            [['plano_descricao_id', 'forma_pagamento_id'], 'default', 'value' => null],
            [['plano_descricao_id', 'forma_pagamento_id'], 'integer'],
            [['plano_descricao_id', 'forma_pagamento_id'], 'unique', 'targetAttribute' => ['plano_descricao_id', 'forma_pagamento_id']],
            [['forma_pagamento_id'], 'exist', 'skipOnError' => true, 'targetClass' => FormaPagamento::class, 'targetAttribute' => ['forma_pagamento_id' => 'id']],
            [['plano_descricao_id'], 'exist', 'skipOnError' => true, 'targetClass' => PlanoDescricao::class, 'targetAttribute' => ['plano_descricao_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'plano_descricao_id' => 'Plano Descricao ID',
            'forma_pagamento_id' => 'Forma Pagamento ID',
        ];
    }

    /**
     * Gets query for [[FormaPagamento]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getFormaPagamento()
    {
        return $this->hasOne(FormaPagamento::class, ['id' => 'forma_pagamento_id']);
    }

    /**
     * Gets query for [[PlanoDescricao]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getPlanoDescricao()
    {
        return $this->hasOne(PlanoDescricao::class, ['id' => 'plano_descricao_id']);
    }
}
