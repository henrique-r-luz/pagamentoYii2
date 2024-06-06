<?php

use app\models\admin\User;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use app\lib\GridViewPadrao as GridView;

/** @var yii\web\View $this */
/** @var app\models\admin\UserSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Users';
?>
<div class="user-index">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800"><?= Html::encode($this->title) ?></h1>
    </div>


    <?= GridView::widget([
        'titulo' => $this->title,
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            [
                'attribute' => 'id',
                'options' => ['style' => 'width:5%;'],
            ],
            'username:ntext',
            'pessoa_id',
            [
                'label' => 'Pessoa',
                'value' => function ($model) {
                    return $model->pessoa->nome;
                }
            ],
            [
                'label' => 'Plano',
                'value' => function ($model) {
                    return 'Plano';
                }
            ],
            [
                'header' => 'Ações',
                'class' => ActionColumn::className(),
                'urlCreator' => function ($action, User $model, $key, $index, $column) {
                    return Url::toRoute([$action, 'id' => $model->id]);
                },
                'options' => ['style' => 'width:6%;']
            ],
        ],
    ]); ?>


</div>