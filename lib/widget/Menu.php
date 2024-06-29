<?php

namespace app\lib\widget;

use yii\base\Widget;
use yii\helpers\Html;

class Menu extends Widget
{
    public $arrayMenu = [];
    const UNICO = 'unico';
    const MULTIPLO = 'multiplo';

    public function run()
    {
        return
            '<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

                 <!-- Sidebar - Brand -->
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/index.php">
                    <div class="sidebar-brand-icon rotate-n-15">
                        <i class="fas fa-laugh-wink fa-2x"></i>
                    </div>
                    <div class="sidebar-brand-text mx-3">Pay Yii2</div>
                 </a>
                 ' . $this->itens() . '

            </ul>';
    }


    private function itens()
    {
        $html = '';
        foreach ($this->arrayMenu as $i => $menu) {
            if ($menu['tipo'] == self::UNICO) {
                $html .= $this->itensUnico($menu);
            }
            if ($menu['tipo'] == self::MULTIPLO) {
                $html .= $this->itensMultiplos($menu, $menu['refAnimacao']);
            }
        }
        return $html;
    }

    private function itensUnico($menu)
    {
        return  '<li id="' . $menu['id'] . '" class="nav-item">
                    <a class="nav-link" href="' . $menu['url'] . '">
                        <i class="' . $menu['icon'] . '"></i>
                        <span>' . $menu['texto'] . '</span>
                    </a>
                </li>';
    }

    private function itensMultiplos($menu, $id)
    {
        return  '<li id="' . $menu['id'] . '" class="nav-item">
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#' . $id . '" aria-expanded="true" aria-controls="' . $id . '">
                        <i class="' . $menu['icon'] . '"></i>
                        <span>' . $menu['texto'] . '</span>
                     </a>
                    <div id="' . $id . '" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                        ' . $this->filhos($menu['filhos']) . '
                        </div>
                    </div>
                </li>';
    }


    private function filhos($itens)
    {
        $html = '';
        foreach ($itens as $item) {
            $html .= '<a id="' . $item['id'] . '" class="collapse-item" href="' . $item['url'] . '">' . $item['texto'] . '</a>';
        }
        return $html;
    }
}
