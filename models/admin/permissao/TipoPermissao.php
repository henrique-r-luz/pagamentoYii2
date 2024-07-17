<?php

namespace app\models\admin\permissao;

class TipoPermissao
{

    const ROTA = 'rota';
    const PAPEIS = 'papeis';
    const PLANO = 'plano';

    public const DESCRICAO = [
        1 => 'rota',
        2 => 'papeis',
        3 => 'plano'
    ];


    public const TYPE = [
        'rota' => 1,
        'papeis' => 2,
        'plano' => 3
    ];
}
