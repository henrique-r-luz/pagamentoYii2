<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\admin\Assinatura $model */

$this->title = 'Atualiza Assinatura: ' . $model->id;
?>
<div class="assinatura-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
    'model' => $model,
    ]) ?>

</div>