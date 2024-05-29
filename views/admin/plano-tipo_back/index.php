<?php

use app\models\PlanoTipo;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use app\lib\GridViewPadrao as GridView;


/** @var yii\web\View $this */
/** @var app\models\PlanoTipoSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Plano Tipos';
$this->params['breadcrumbs'][] = $this->title;

?>
<div class="plano-tipo-index">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800"><?= Html::encode($this->title) ?></h1>
    </div>
    <p>
        DataTables is a third party plugin that is used to generate the demo table below.

    </p>
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,

        'columns' => [
            //'id',
            [
                'attribute' => 'id',
                'options' => ['style' => 'width:5%;'],
            ],
            'nome:ntext',
            [
                'header' => 'Ações',
                'class' => ActionColumn::className(),
                'urlCreator' => function ($action, PlanoTipo $model, $key, $index, $column) {
                    return Url::toRoute([$action, 'id' => $model->id]);
                },
                'options' => ['style' => 'width:6%;']
            ],
        ],
    ]); ?>


</div>