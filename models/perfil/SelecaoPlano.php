<?php

namespace app\models\perfil;

use Yii;
use yii\base\Model;
use app\validator\ValidaPlano;

class SelecaoPlano extends Model
{

    public ?int $plano_id = null;
    public function rules()
    {
        return [
            [['plano_id'], 'required'],
            [['plano_id'], 'integer'],
            [['plano_id'], 'verificaPlanoAtivo']
        ];
    }

    public function attributeLabels()
    {
        return [
            'plano_id' => 'Slecione o Plano'
        ];
    }

    public function verificaPlanoAtivo()
    {

        if (!ValidaPlano::valida(Yii::$app->user->id)) {
            $this->addError('plano_id', 'Você já possui um plano ativo! Calcele o atual para criar um novo');
        }
    }
}
