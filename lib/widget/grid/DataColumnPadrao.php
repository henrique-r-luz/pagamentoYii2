<?php

namespace app\lib\widget\grid;

use yii\helpers\Html;
use kartik\grid\DataColumn;

class DataColumnPadrao extends DataColumn
{
    /**
     * @inheritdoc
     */
    public function renderDataCell($model, $key, $index)
    {
        $options = $this->fetchContentOptions($model, $key, $index);
        $this->parseGrouping($options, $model, $key, $index);
        $this->parseExcelFormats($options, $model, $key, $index);
        $this->initPjax($this->_clientScript);

        $options = array_merge($options, ['style' => "color:#858796"]);
        return Html::tag('td', $this->renderDataCellContent($model, $key, $index), $options);
    }
}
