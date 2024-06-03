<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\admin\Assinatura $model */

$this->title = 'Cria Assinatura';
?>
<div class="assinatura-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
    'model' => $model,
    ]) ?>

</div>