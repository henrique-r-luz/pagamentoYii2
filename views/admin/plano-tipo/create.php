<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\admin\PlanoTipo $model */

$this->title = 'Cria Plano';
?>
<div class="plano-tipo-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>