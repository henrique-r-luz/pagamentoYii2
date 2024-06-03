<?php

namespace app\lib;

use yii\helpers\Url;
use yii\helpers\Html;
use kartik\grid\GridView;

class GridViewPadrao extends GridView
{
    public $titulo = '';
    public $dataColumnClass = DataColumnPadrao::class;
    public $pagination = 10;
    public $create = true;

    public function init()
    {
        if ($this->create == true) {
            $this->create =  '<a href="' . Url::to(['create']) . '" class="btn btn-primary btn-icon-split ml-auto">
                            <span class="icon text-white-50">
                                <i class="fas fa-plus"></i>
                            </span>
                            <span class="text">Novo</span>
                        </a>';
        } else {
            $this->create = '';
        }


        $this->layout = '
    <div class="card shadow mb-4">
        <div class="card-header d-flex py-3">
          
               <h5 class="m-0 font-weight-bold text-primary"> Lista de ' . $this->titulo . '  </h5>
               ' . $this->create . '
          
        </div>
        <div class="card-body">
            {items}
        </div>
        <div class="card-footer clearfix">
             {pager}
      </div>
    </div>
';
        // $this->initToolBar();


        if ($this->dataProvider->getPagination() !== false) {
            $this->dataProvider->pagination->defaultPageSize = $this->pagination;
        }

        parent::init();
    }
}
