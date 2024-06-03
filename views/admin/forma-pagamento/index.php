<?php

use app\models\admin\FormaPagamento;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use app\lib\GridViewPadrao as GridView;

/** @var yii\web\View $this */
/** @var app\models\admin\FormaPagamentoSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Forma Pagamentos';
?>
<div class="forma-pagamento-index">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800"><?= Html::encode($this->title) ?></h1>
    </div>

    
            <?= GridView::widget([
        'titulo'=>$this->title,
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
        [
                        'attribute' => 'id',
                        'options' => ['style' => 'width:5%;'],
                    ],
            'tipo_pagamento:ntext',
            'meio_pagamento:ntext',
        [
        'header' => 'Ações',
        'class' => ActionColumn::className(),
        'urlCreator' => function ($action, FormaPagamento $model, $key, $index, $column) {
        return Url::toRoute([$action, 'id' => $model->id]);
        },
        'options' => ['style' => 'width:6%;']
        ],
        ],
        ]); ?>
    
    
</div>