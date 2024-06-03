<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\admin\Pessoa $model */

$this->title = 'Atualiza Pessoa: ' . $model->id;
?>
<div class="pessoa-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
    'model' => $model,
    ]) ?>

</div>