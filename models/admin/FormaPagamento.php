<?php

namespace app\models\admin;

use Yii;
use app\models\PlanoDescricao;
use app\models\ItensFormaPagamento;

/**
 * This is the model class for table "forma_pagamento".
 *
 * @property int $id
 * @property string $tipo_pagamento
 * @property string $meio_pagamento
 *
 * @property ItensFormaPagamento[] $itensFormaPagamentos
 * @property PlanoDescricao[] $planoDescricaos
 */
class FormaPagamento extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'forma_pagamento';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['tipo_pagamento', 'meio_pagamento'], 'required'],
            [['tipo_pagamento', 'meio_pagamento'], 'string'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'tipo_pagamento' => 'Tipo Pagamento',
            'meio_pagamento' => 'Meio Pagamento',
        ];
    }

    /**
     * Gets query for [[ItensFormaPagamentos]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getItensFormaPagamentos()
    {
        return $this->hasMany(ItensFormaPagamento::class, ['forma_pagamento_id' => 'id']);
    }

    /**
     * Gets query for [[PlanoDescricaos]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getPlanoDescricaos()
    {
        return $this->hasMany(PlanoDescricao::class, ['id' => 'plano_descricao_id'])->viaTable('itens_forma_pagamento', ['forma_pagamento_id' => 'id']);
    }
}
