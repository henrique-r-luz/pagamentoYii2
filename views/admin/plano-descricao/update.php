<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\admin\PlanoDescricao $model */

$this->title = 'Atualiza Plano Descricao: ' . $model->id;
?>
<div class="plano-descricao-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
    'model' => $model,
    ]) ?>

</div>