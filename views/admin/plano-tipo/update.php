<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\admin\PlanoTipo $model */

$this->title = 'Atualiza Plano Tipo: ' . $model->id;
?>
<div class="plano-tipo-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
    'model' => $model,
    ]) ?>

</div>