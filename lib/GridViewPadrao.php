<?php

namespace app\lib;

use kartik\grid\GridView;

class GridViewPadrao extends GridView
{
    public $titulo = '';
    public $dataColumnClass = DataColumnPadrao::class;
    public $pagination = 10;

    public function init()
    {
        $this->layout = '
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h5 class="m-0 font-weight-bold text-primary"> Lista de ' . $this->titulo . '  </h5>
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
