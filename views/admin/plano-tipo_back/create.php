<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\PlanoTipo $model */

$this->title = 'Create Plano Tipo';
$this->params['breadcrumbs'][] = ['label' => 'Plano Tipos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="plano-tipo-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
