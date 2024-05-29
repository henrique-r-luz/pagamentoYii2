<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\admin\PlanoTipo $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="plano-tipo-form">
    <div class="card shadow mb-4">
        <div class="card-body">
            <?php $form = ActiveForm::begin(); ?>

                <?= $form->field($model, 'nome')->textarea(['rows' => 6]) ?>

            <div class="form-group">
                <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
                <?= Html::a('Voltar',['index'], ['class' => 'btn btn-default']) ?>
            </div>

            <?php ActiveForm::end(); ?>
        </div>
    </div>
</div>