<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/** @var yii\web\View $this */
/** @var app\models\admin\Assinatura $model */

$this->title = $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Assinaturas', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="assinatura-view">

    <h1>Id:<?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->id], [
        'class' => 'btn btn-danger',
        'data' => [
        'confirm' => 'Are you sure you want to delete this item?',
        'method' => 'post',
        ],
        ]) ?>
        <?= Html::a('Voltar',['index'], ['class' => 'btn btn-info']) ?>
    </p>

    <?= DetailView::widget([
    'model' => $model,
    'attributes' => [
                'id',
            'user_id',
            'plano_tipo_id',
            'data_inicio',
            'data_fim',
    ],
    ]) ?>

</div>