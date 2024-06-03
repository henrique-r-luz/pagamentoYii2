<?php

use app\models\admin\PlanoTipo;
use yii\helpers\Html;
use yii\helpers\Url;
use app\lib\ActionColumn;
use app\lib\ActionColumnPadrao;
use app\lib\GridViewPadrao as GridView;

/** @var yii\web\View $this */
/** @var app\models\admin\PlanoTipoSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Plano';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="plano-tipo-index">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800"><?= Html::encode($this->title) ?></h1>
    </div>


    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'titulo' => 'Planos',
        'columns' => [
            [
                'attribute' => 'id',
                'options' => ['style' => 'width:5%;'],
            ],
            'nome:ntext',
            [
                'header' => 'Ações',
                'class' => ActionColumnPadrao::className(),
                'template' => '{view} {update} {delete} {descricao}',
                'buttons' => [
                    'descricao' => function ($url, $model, $key) {
                        return Html::a('<i class="fas fa-wrench"></i>', $url, [
                            'title' => 'Descrição do plano',
                            'data-pjax' => '0',
                        ]);
                    },
                ],
                'options' => ['style' => 'width:6%;']
            ],
        ],
    ]); ?>


</div>