<?php

use yii\widgets\Menu;
?>
<?= Menu::widget([
    'options' => ['class' => 'navbar-nav bg-gradient-primary sidebar sidebar-dark accordion', 'id' => 'accordionSidebar'],
    'items' => [
        [
            'label' => 'Gratuíto',
            'url' => ['/gratuito'],
            'template' => '<a class="nav-link" href="{url}"><i class="fas fa-fw fa-chart-area"></i><span>{label}</span></a>',
            'options' => ['class' => 'nav-item', 'id' => 'nav-gratuito'],
        ],
        [
            'label' => 'Pago',
            'url' => ['/pago'],
            'template' => '<a class="nav-link" href="{url}"><i class="fas fa-fw fa-table"></i><span>{label}</span></a>',
            'options' => ['class' => 'nav-item', 'id' => 'nav-pago'],
        ],
        [
            'label' => 'Admin',
            'url' => '#',
            'template' => '<a class="nav-link collapsed" href="{url}" data-toggle="collapse" data-target="#adm" aria-expanded="true" aria-controls="adm"><i class="fas fa-fw fa-cog"></i><span>{label}</span></a>',
            'options' => ['class' => 'nav-item', 'id' => 'nav-admin'],
            'items' => [
                ['label' => 'Pessoa', 'url' => ['/admin/pessoa'], 'template' => '<a id="a-pessoa" class="collapse-item" href="{url}">{label}</a>'],
                ['label' => 'User', 'url' => ['/admin/user'], 'template' => '<a id="a-user" class="collapse-item" href="{url}">{label}</a>'],
                ['label' => 'Planos', 'url' => ['/admin/plano-tipo'], 'template' => '<a id="a-plano-tipo" class="collapse-item" href="{url}">{label}</a>'],
                ['label' => 'Forma Pagamento', 'url' => ['/admin/forma-pagamento'], 'template' => '<a id="a-forma-pagamento" class="collapse-item" href="{url}">{label}</a>'],
                ['label' => 'Assinatura', 'url' => ['/admin/assinatura'], 'template' => '<a id="a-assinatura" class="collapse-item" href="{url}">{label}</a>'],
            ],
            'submenuTemplate' => '<div id="adm" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
    <div class="bg-white py-2 collapse-inner rounded">{items}</div>
</div>',
        ],
    ],
]);
?>