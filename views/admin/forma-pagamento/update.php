<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\admin\FormaPagamento $model */

$this->title = 'Atualiza Forma Pagamento: ' . $model->id;
?>
<div class="forma-pagamento-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
    'model' => $model,
    ]) ?>

</div>