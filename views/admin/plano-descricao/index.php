<?php

use app\models\admin\PlanoDescricao;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use app\lib\GridViewPadrao as GridView;

/** @var yii\web\View $this */
/** @var app\models\admin\PlanoDescricaoSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Plano Descricaos';
?>
<div class="plano-descricao-index">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800"><?= Html::encode($this->title) ?></h1>
    </div>


    <?= GridView::widget([
        'titulo' => $this->title,
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'create' => false,
        'columns' => [
            [
                'attribute' => 'id',
                'options' => ['style' => 'width:5%;'],
            ],
            'plano_tipo_id',
            'auth_item_name:ntext',
            'frequencia',
            'tipo_frequencia',
            'repeticao',
            //'back_url:ntext',
            //'dia_compra',
            //'dia_compra_proporcional',
            //'valor_plano',
            //'currency_id:ntext',
            //'descricao_fatura:ntext',
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