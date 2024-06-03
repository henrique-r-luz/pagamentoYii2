<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\admin\User $model */

$this->title = 'Atualiza User: ' . $model->id;
?>
<div class="user-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
    'model' => $model,
    ]) ?>

</div>