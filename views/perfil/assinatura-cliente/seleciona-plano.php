<?php

use yii\widgets\ActiveForm;
use app\models\admin\PlanoTipo;

?>


<div class="user-form">
    <div class="card shadow mb-4">
        <div class="card-body">
            <?php $form = ActiveForm::begin(); ?>
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <?= $form->field($model, 'plano_id')->dropDownList(PlanoTipo::listaPlanoComDescricao(), ['prompt' => '---Selecione o plano---']) ?>
                </div>
            </div>


            <div class="form-group">
                <button class="btn btn-secondary btn-icon-split">
                    <span class="icon text-white-50">
                        <i class="fas fa-arrow-right"></i>
                    </span>
                    <span class="text">Proximo</span>
                </button>
            </div>

            <?php ActiveForm::end(); ?>
        </div>
    </div>
</div>