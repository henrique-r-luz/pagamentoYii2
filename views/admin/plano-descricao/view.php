<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/** @var yii\web\View $this */
/** @var app\models\admin\PlanoDescricao $model */

$this->title = $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Plano Descricaos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
\yii\web\YiiAsset::register($this);
?>
<div class="plano-descricao-view">

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
            'plano_tipo_id',
            'auth_item_name:ntext',
            'frequencia',
            'tipo_frequencia',
            'repeticao',
            'back_url:ntext',
            'dia_compra',
            'dia_compra_proporcional',
            'valor_plano',
            'currency_id:ntext',
            'descricao_fatura:ntext',
    ],
    ]) ?>

</div>