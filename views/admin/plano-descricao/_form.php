<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\admin\PlanoDescricao $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="plano-descricao-form">
    <div class="card shadow mb-4">
        <div class="card-body">
            <?php $form = ActiveForm::begin(); ?>
            <div class="row">
                <div class="col-xs-4 col-sm-4 col-lg-4">
                    <?= $form->field($model, 'plano_tipo_id')->textInput() ?>
                </div>
                <div class="col-xs-4 col-sm-4 col-lg-4">
                    <?= $form->field($model, 'auth_item_name')->textInput() ?>
                </div>
                <div class="col-xs-4 col-sm-4 col-lg-4">
                    <?= $form->field($model, 'frequencia')->textInput() ?>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4 col-sm-4 col-lg-4">
                    <?= $form->field($model, 'tipo_frequencia')->textInput() ?>
                </div>
                <div class="col-xs-4 col-sm-4 col-lg-4">
                    <?= $form->field($model, 'repeticao')->textInput() ?>
                </div>
                <div class="col-xs-4 col-sm-4 col-lg-4">
                    <?= $form->field($model, 'back_url')->textInput() ?>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4 col-sm-4 col-lg-4">
                    <?= $form->field($model, 'dia_compra')->textInput() ?>
                </div>
                <div class="col-xs-4 col-sm-4 col-lg-4">
                    <?= $form->field($model, 'dia_compra_proporcional')->textInput() ?>
                </div>
                <div class="col-xs-4 col-sm-4 col-lg-4">
                    <?= $form->field($model, 'valor_plano')->textInput() ?>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <?= $form->field($model, 'currency_id')->textInput() ?>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <?= $form->field($model, 'descricao_fatura')->textInput() ?>
                </div>
            </div>

            <div class="form-group">
                <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
                <?= Html::a('Voltar', ['index'], ['class' => 'btn btn-info']) ?>
            </div>

            <?php ActiveForm::end(); ?>
        </div>
    </div>
</div>