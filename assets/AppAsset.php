<?php

/**
 * @link https://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license https://www.yiiframework.com/license/
 */

namespace app\assets;

use yii\web\AssetBundle;

/**
 * Main application asset bundle.
 *
 * @author Qiang Xue <qiang.xue@gmail.com>
 * @since 2.0
 */
class AppAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl = '@web';
    public $css = [
        'css/sb-admin-2.css',
        "js/grow-js/jquery.growl.css",
    ];
    public $js = [
        "js/grow-js/jquery.growl.js",
        'vendor/bootstrap/js/bootstrap.bundle.min.js',
        'vendor/jquery-easing/jquery.easing.min.js',
        'js/sb-admin-2.min.js',
        'js/menu.js',


    ];
    public $depends = [
        'yii\web\YiiAsset',
        'yii\bootstrap5\BootstrapAsset',
        'yidas\yii\fontawesome\FontawesomeAsset',
    ];

    public $publishOptions = [
        'forceCopy' => YII_ENV_DEV,
    ];
}
