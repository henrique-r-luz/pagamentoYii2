<?php

namespace app\service\admin;

use Yii;
use Throwable;
use app\models\admin\User;
use app\lib\PagamentoException;
use app\models\admin\PlanoTipo;
use app\models\admin\permissao\AuthAssignment;

class UserService
{



    public function criaUser(User $user)
    {
        $transaction = Yii::$app->db->beginTransaction();
        try {
            if (!$user->save()) {
                throw new PagamentoException('Erro ao inserir User');
            }
            $user->refresh();
            $plano  = PlanoTipo::findOne($user->plano_id);
            $authAssignment = new AuthAssignment();
            $authAssignment->user_id = strval($user->id);
            $authAssignment->item_name =  $plano->auth_item_name;
            if (!$authAssignment->save()) {
                throw new PagamentoException('Erro ao inserir authAssignment');
            }
            $transaction->commit();
        } catch (PagamentoException $e) {
            $transaction->rollBack();
            throw new PagamentoException($e->getMessage());
        } catch (Throwable $e) {
            $transaction->rollBack();
            throw new PagamentoException("Ocorreu um erro inesperado!");
        }
    }
}
