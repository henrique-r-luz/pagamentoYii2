<?php

namespace app\models\perfil;

use yii\base\Model;

class SelecaoPlano extends Model
{

    public ?int $plano_id = null;
    public function rules()
    {
        return [
            [['plano_id'], 'required'],
            [['plano_id'], 'integer'],
        ];
    }

    public function attributeLabels()
    {
        return [
            'plano_id' => 'Slecione o Plano'
        ];
    }
}
