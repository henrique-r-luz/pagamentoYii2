<?php

use app\models\admin\Pessoa;
use app\models\admin\PlanoTipo;
use yii\helpers\Html;
use yii\widgets\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\admin\User $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="user-form">
    <div class="card shadow mb-4">
        <div class="card-body">
            <?php $form = ActiveForm::begin(); ?>
            <div class="row">
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <?= $form->field($model, 'username')->textInput() ?>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <?= $form->field($model, 'password')->passwordInput() ?>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <?= $form->field($model, 'pessoa_id')->dropDownList(Pessoa::listaPessoa(), ['prompt' => '---Selecione a pessoa---']) ?>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <?= $form->field($model, 'plano_id')->dropDownList(PlanoTipo::listaPlano(), ['prompt' => '---Selecione o plano---']) ?>
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