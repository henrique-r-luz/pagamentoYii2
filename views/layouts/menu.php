<?php

use app\lib\widget\Menu;

?>
<?= Menu::widget([
    "arrayMenu" => [
        ['tipo' => Menu::UNICO, 'id' => 'nav-gratuito', 'icon' => 'fas fa-fw fa-chart-area', 'url' => '/gratuito', 'texto' => 'Gratuíto'],
        ['tipo' => Menu::UNICO, 'id' => 'nav-pago', 'icon' => 'fas fa-fw fa-table', 'url' => '/pago', 'texto' => 'Pago'],
        ['tipo' => Menu::UNICO, 'id' => 'nav-conteudo-prata', 'icon' => 'fas fa-star', 'url' => '/conteudo-prata', 'texto' => 'Conteudo Prata'],
        ['tipo' => Menu::UNICO, 'id' => 'nav-conteudo-ouro', 'icon' => 'fas fa-ring', 'url' => '/conteudo-ouro', 'texto' => 'Conteudo Ouro'],

        [
            'tipo' => Menu::MULTIPLO, 'id' => 'nav-admin', 'icon' => 'fas fa-fw fa-cog', 'texto' => 'Admin', 'refAnimacao' => 'adm',
            'filhos' => [
                ['id' => 'a-pessoa', 'url' => '/admin/pessoa', 'texto' => 'Pessoa'],
                ['id' => 'a-user', 'url' => '/admin/user', 'texto' => 'User'],
                ['id' => 'a-plano-tipo', 'url' => '/admin/plano-tipo', 'texto' => 'Plano'],
                ['id' => 'a-assinatura', 'url' => '/admin/assinatura', 'texto' => 'Assinatura']
            ]
        ],
    ]
])
?>