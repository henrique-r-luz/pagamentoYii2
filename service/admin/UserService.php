<?php

namespace app\service\admin;

use Yii;
use Throwable;
use app\models\admin\User;
use app\lib\PagamentoException;
use app\models\admin\PlanoTipo;
use app\models\admin\Assinatura;
use app\lib\dicionario\StatusAssinatura;
use app\models\admin\permissao\AuthAssignment;

class UserService
{

    public function criaUser(User $user, PlanoTipo $plano)
    {
        $transaction = Yii::$app->db->beginTransaction();
        try {
            if (!$user->save()) {
                throw new PagamentoException('Erro ao inserir User');
            }
            $user->refresh();
            $this->criaPermissao($user, $plano);
            $this->criaAssinatura($user, $plano);
            $transaction->commit();
        } catch (PagamentoException $e) {
            $transaction->rollBack();
            throw new PagamentoException($e->getMessage());
        } catch (Throwable $e) {

            $transaction->rollBack();
            throw new PagamentoException("Ocorreu um erro inesperado!");
        }
    }

    private function criaPermissao($user, $plano)
    {

        $authAssignment = new AuthAssignment();
        $authAssignment->user_id = strval($user->id);
        $authAssignment->item_name =  $plano->auth_item_name;
        if (!$authAssignment->save()) {
            throw new PagamentoException('Erro ao inserir authAssignment');
        }
    }

    private function criaAssinatura($user, $plano)
    {
        $objetoData = new \DateTime;
        $data = (int) $objetoData->getTimestamp();
        $assinatura = new Assinatura();
        $assinatura->user_id = $user->id;
        $assinatura->plano_tipo_id = $plano->id;
        $assinatura->data_inicio = date('Y-m-d H:i:s');
        $assinatura->created_at  = $data;
        $assinatura->status = StatusAssinatura::AUTHORIZED;
        if (!$assinatura->save()) {
            throw new PagamentoException('Erro ao inserir Assinatura');
        }
    }
}
