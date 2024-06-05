<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use app\models\admin\permissao\AuthItem;

/** @var yii\web\View $this */
/** @var app\models\admin\PlanoTipo $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="plano-tipo-form">
    <div class="card shadow mb-4">
        <div class="card-body">
            <?php $form = ActiveForm::begin(); ?>
            <div class="row">
                <div class="col-12 col-sm-6 col-lg-6">
                    <?= $form->field($model, 'nome')->textInput() ?>
                </div>
                <div class="col-12 col-sm-6 col-lg-6">
                    <?= $form->field($model, 'auth_item_name')->dropDownList(AuthItem::getPlanos(), ['prompt' => '---Selecione a permissão---']) ?>
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