<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\admin\PlanoDescricao $model */

$this->title = 'Descricao do ' . $model->planoTipo->nome . ' id:' . $model->planoTipo->id;
?>
<div class="plano-descricao-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
        'plano_id' => $plano_id
    ]) ?>

</div>