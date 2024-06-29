<?php

use app\models\admin\PlanoDescricao;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use app\lib\widget\grid\GridViewPadrao as GridView;

/** @var yii\web\View $this */
/** @var app\models\admin\PlanoDescricaoSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Descricao do ' . $dataProvider->getModels()[0]->planoTipo->nome . ', id:' . $dataProvider->getModels()[0]->planoTipo->id;
?>
<div class="plano-descricao-index">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800"><?= Html::encode($this->title) ?></h1>
    </div>


    <?= GridView::widget([
        'titulo' => 'Descrição de plano',
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'create' => '<a href="' . Url::to(['admin/plano-tipo']) . '" class="btn btn-secondary btn-icon-split ml-auto">
        <span class="icon text-white-50">
            <i class="fas fa-arrow-left"></i>
        </span>
        <span class="text">Voltar</span>
    </a>',
        'columns' => [
            [
                'attribute' => 'id',
                'options' => ['style' => 'width:5%;'],
            ],
            'plano_api_id',
            'frequencia',
            'tipo_frequencia',
            'repeticao',
            'dia_compra',
            'valor_plano',
            [
                'header' => 'Ações',
                'class' => ActionColumn::className(),
                'urlCreator' => function ($action, PlanoDescricao $model, $key, $index, $column) {
                    return Url::toRoute([$action, 'id' => $model->id]);
                },
                'options' => ['style' => 'width:6%;']
            ],
        ],
    ]); ?>


</div>