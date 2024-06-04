<?php

use yii\helpers\Url;

//$this->registerJsFile(Url::to('@web/js/menu.js'), ['depends' => [\yii\web\JqueryAsset::className()]]);

?>
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/index.php">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink fa-2x"></i>
        </div>
        <div class="sidebar-brand-text mx-3">SB Admin <sup>2</sup></div>
    </a>

    <!-- Nav Item - Charts -->
    <li id="nav-gratuito" class="nav-item">
        <a class="nav-link" href="/gratuito">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Gratuíto</span></a>
    </li>

    <!-- Nav Item - Tables -->
    <li id="nav-pago" class="nav-item">
        <a class="nav-link" href="/pago">
            <i class="fas fa-fw fa-table"></i>
            <span>Pago</span></a>
    </li>
    <li id="nav-admin" class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#adm" aria-expanded="true" aria-controls="adm">
            <i class="fas fa-fw fa-cog"></i>
            <span>Admin</span>
        </a>
        <div id="adm" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <a id="a-pessoa" class="collapse-item" href="/admin/pessoa">Pessoa</a>
                <a id="a-user" class="collapse-item" href="/admin/user">User</a>
                <a id="a-plano-tipo" class="collapse-item" href="/admin/plano-tipo">Planos</a>
                <a id="a-forma-pagamento" class="collapse-item" href="/admin/forma-pagamento">Forma Pagamento</a>
                <a id="a-assinatura" class="collapse-item" href="/admin/assinatura">Assinatura</a>
            </div>
        </div>
    </li>

</ul>