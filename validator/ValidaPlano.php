<?php

namespace app\validator;

use app\models\admin\Assinatura;
use app\lib\dicionario\StatusAssinatura;
use app\models\admin\PlanoTipo;

class ValidaPlano
{

    public static function valida($user_id)
    {
        if (Assinatura::find()
            ->joinWith(['planoTipo'])
            ->where(['user_id' => $user_id])
            ->andWhere(['status' => StatusAssinatura::AUTHORIZED])
            ->andWhere(['<>', 'nome', PlanoTipo::PLANO_PADRAO])
            ->exists()
        ) {
            return false;
        }
        return true;
    }
}
