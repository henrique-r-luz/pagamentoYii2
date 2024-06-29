<?php

use yii\helpers\Inflector;
use yii\helpers\StringHelper;

/** @var yii\web\View $this */
/** @var yii\gii\generators\crud\Generator $generator */

$modelClass = StringHelper::basename($generator->modelClass);

echo "<?php\n";
?>

use <?= $generator->modelClass ?>;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use app\lib\widget\grid\GridViewPadrao as GridView;
<?= $generator->enablePjax ? 'use yii\widgets\Pjax;' : '' ?>

/** @var yii\web\View $this */
<?= !empty($generator->searchModelClass) ? "/** @var " . ltrim($generator->searchModelClass, '\\') . " \$searchModel */\n" : '' ?>
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = <?= $generator->generateString(Inflector::pluralize(Inflector::camel2words(StringHelper::basename($generator->modelClass)))) ?>;
?>
<div class="<?= Inflector::camel2id(StringHelper::basename($generator->modelClass)) ?>-index">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800"><?= "<?= " ?>Html::encode($this->title) ?></h1>
    </div>

    <?= $generator->enablePjax ? "    <?php Pjax::begin(); ?>\n" : '' ?>

    <?php if ($generator->indexWidgetType === 'grid') : ?>
        <?= "<?= " ?>GridView::widget([
        'titulo'=>$this->title,
        'dataProvider' => $dataProvider,
        <?= !empty($generator->searchModelClass) ? "'filterModel' => \$searchModel,\n        'columns' => [\n" : "'columns' => [\n"; ?>
        <?php
        $count = 0;
        if (($tableSchema = $generator->getTableSchema()) === false) {
            foreach ($generator->getColumnNames() as $name) {
                if (++$count < 6) {
                    echo "            '" . $name . "',\n";
                } else {
                    echo "            //'" . $name . "',\n";
                }
            }
        } else {
            foreach ($tableSchema->columns as $column) {
                $format = $generator->generateColumnFormat($column);
                if ($column->name == 'id') {
                    echo  "[
                        'attribute' => 'id',
                        'options' => ['style' => 'width:5%;'],
                    ],\n";
                    continue;
                }
                if (++$count < 6) {
                    echo "            '" . $column->name . ($format === 'text' ? "" : ":" . $format) . "',\n";
                } else {
                    echo "            //'" . $column->name . ($format === 'text' ? "" : ":" . $format) . "',\n";
                }
            }
        }
        ?>
        [
        'header' => 'Ações',
        'class' => ActionColumn::className(),
        'urlCreator' => function ($action, <?= $modelClass ?> $model, $key, $index, $column) {
        return Url::toRoute([$action, <?= $generator->generateUrlParams() ?>]);
        },
        'options' => ['style' => 'width:6%;']
        ],
        ],
        ]); ?>
    <?php else : ?>
        <?= "<?= " ?>ListView::widget([
        'dataProvider' => $dataProvider,
        'itemOptions' => ['class' => 'item'],
        'itemView' => function ($model, $key, $index, $widget) {
        return Html::a(Html::encode($model-><?= $generator->getNameAttribute() ?>), ['view', <?= $generator->generateUrlParams() ?>]);
        },
        ]) ?>
    <?php endif; ?>

    <?= $generator->enablePjax ? "    <?php Pjax::end(); ?>\n" : '' ?>

</div>