<?php

namespace app\lib\helper;

use app\lib\dicionario\StatusAssinatura;

class StatusApi
{



    public static function all()
    {
        $status = [
            StatusAssinatura::AUTHORIZED => '<span class="badge bg-success" style="font-size:90%">Ativa</span>',
            StatusAssinatura::CANCELLED => '<span class="badge bg-danger" style="font-size:90%">Cancelada</span>',
            StatusAssinatura::PAUSE => '<span class="badge bg-warning" style="font-size:90%">Pausa</span>',
            StatusAssinatura::PAUSE => '<span class="badge bg-primary" style="font-size:90%">Suspensa</span>',
        ];
        return $status;
    }
}
