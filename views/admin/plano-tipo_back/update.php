<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\PlanoTipo $model */

$this->title = 'Update Plano Tipo: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Plano Tipos', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="plano-tipo-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
