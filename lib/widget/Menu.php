<?php

namespace app\lib\widget;

use Yii;
use yii\base\Widget;

class Menu extends Widget
{
    public $arrayMenu = [];
    const UNICO = 'unico';
    const MULTIPLO = 'multiplo';
    private  $menuPaiOpen = [];



    public function run()
    {
        $this->menuPaiOpen = [];
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
        $css = $this->verificaController($menu);

        return  '<li id="' . $menu['id'] . '" class="' . $css['css'] . '">
                    <a class="nav-link" href="' . $menu['url'] . '">
                        <i class="' . $menu['icon'] . '"></i>
                        <span>' . $menu['texto'] . '</span>
                    </a>
                </li>';
    }

    private function itensMultiplos($menu, $id)
    {

        $html = '';
        $filhos = '';
        foreach ($menu['filhos'] as $item) {
            $css = $this->verificaController($item, $menu['id']);
            $filhos .=  $this->filhos($item, $css);

            $html =   '<li id="' . $menu['id'] . '" class="' . $css['css'] . '">
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#' . $id . '" aria-expanded="true" aria-controls="' . $id . '">
                        <i class="' . $menu['icon'] . '"></i>
                        <span>' . $menu['texto'] . '</span>
                     </a>
                    <div id="' . $id . '" class="' . $css['cssPai'] . '" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                        ' . $filhos . '
                        </div>
                    </div>
                </li>';
        }
        return $html;
    }


    private function filhos($item, $css)
    {

        return  '<a id="' . $item['id'] . '" class="' . $css['cssFilho'] . '" href="' . $item['url'] . '">' . $item['texto'] . '</a>';
    }

    private function verificaController($menu, $idMenuPai = null)
    {
        $css =  'nav-item';
        $cssPai =  'collapse';
        if (
            $idMenuPai != null &&
            isset($this->menuPaiOpen[$idMenuPai]) &&
            $this->menuPaiOpen[$idMenuPai] == true
        ) {
            $css =  'nav-item active';
            $cssPai =  'collapse show';
        }
        $cssFilho = "collapse-item";
        if (!isset($menu['url'])) {
            return ['css' => $css, 'cssPai' => $cssPai, 'cssFilho' => $cssFilho];
        };

        if ('/' . Yii::$app->controller->id == $menu['url']) {
            $this->menuPaiOpen[$idMenuPai] = true;
            $css = "nav-item active";
            $cssPai = "collapse show";
            $cssFilho = "collapse-item active";
        }
        return ['css' => $css, 'cssPai' => $cssPai, 'cssFilho' => $cssFilho];
    }
}
