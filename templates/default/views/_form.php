<?php

use yii\helpers\Inflector;
use yii\helpers\StringHelper;

/** @var yii\web\View $this */
/** @var yii\gii\generators\crud\Generator $generator */

/* @var $model \yii\db\ActiveRecord */
$model = new $generator->modelClass();
$safeAttributes = $model->safeAttributes();
if (empty($safeAttributes)) {
    $safeAttributes = $model->attributes();
}

echo "<?php\n";
?>

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/** @var yii\web\View $this */
/** @var <?= ltrim($generator->modelClass, '\\') ?> $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="<?= Inflector::camel2id(StringHelper::basename($generator->modelClass)) ?>-form">
    <div class="card shadow mb-4">
        <div class="card-body">
            <?= "<?php " ?>$form = ActiveForm::begin(); ?>

            <?php foreach ($generator->getColumnNames() as $attribute) {
                if (in_array($attribute, $safeAttributes)) {
                    echo "    <?= " . $generator->generateActiveField($attribute) . " ?>\n\n";
                }
            } ?>
            <div class="form-group">
                <?= "<?= " ?>Html::submitButton(<?= $generator->generateString('Save') ?>, ['class' => 'btn btn-success']) ?>
                <?= "<?= " ?>Html::a(<?= $generator->generateString('Voltar') ?>,['index'], ['class' => 'btn btn-info']) ?>
            </div>

            <?= "<?php " ?>ActiveForm::end(); ?>
        </div>
    </div>
</div>