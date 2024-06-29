<?php

use yii\helpers\Url;
use yii\helpers\Html;
use app\lib\ActionColumn;
use app\lib\widget\grid\ActionColumnPadrao;
use app\models\admin\PlanoTipo;
use app\models\admin\PlanoDescricao;
use app\models\admin\PlanoTipoSearch;
use app\lib\widget\grid\GridViewPadrao as GridView;
use app\models\admin\PlanoDescricaoSearch;

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
                'label' => 'Permissão',
                'attribute' => 'auth_item_name',
                'options' => ['style' => 'width:8%;'],
            ],
            [
                'label' => 'Pago',
                'attribute' => 'plano_descricao_id',
                'filter' => [PlanoTipoSearch::SIM => 'Sim', PlanoTipoSearch::NAO => 'Não'],
                'options' => ['style' => 'width:8%;'],
                'value' => function ($model) {
                    if ($model->plano_descricao_id == null || $model->plano_descricao_id == '') {
                        return "Não";
                    }
                    return "Sim";
                }
            ],
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