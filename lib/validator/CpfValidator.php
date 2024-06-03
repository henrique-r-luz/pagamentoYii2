<?php

namespace app\lib\validator;

use yii\validators\Validator;

class CpfValidator extends Validator
{
    public function validateAttribute($model, $attribute)
    {
        $cpf = $model->$attribute;
        if (!$this->isValidCpf($cpf)) {
            $this->addError($model, $attribute, 'CPF inválido.');
        }
    }

    private function isValidCpf($cpf)
    {
        // Remove possíveis máscaras
        $cpf = preg_replace('/[^0-9]/', '', $cpf);

        // Verifica se o CPF tem 11 dígitos
        if (strlen($cpf) != 11) {
            return false;
        }

        // Verifica se todos os dígitos são iguais (000.000.000-00, 111.111.111-11, etc.)
        if (preg_match('/(\d)\1{10}/', $cpf)) {
            return false;
        }

        // Calcula os dígitos verificadores para verificar se o CPF é válido
        for ($t = 9; $t < 11; $t++) {
            for ($d = 0, $c = 0; $c < $t; $c++) {
                $d += $cpf[$c] * (($t + 1) - $c);
            }

            $d = ((10 * $d) % 11) % 10;

            if ($cpf[$c] != $d) {
                return false;
            }
        }

        return true;
    }
}
