<?php

use app\lib\rbac\AcessControlPagamento;

//diretório de arquivos

Yii::setAlias('arquivos', dirname(__DIR__) . '/arquivos');
Yii::setAlias('img', dirname(__DIR__) . '/web/img');

$params = require __DIR__ . '/params.php';
$db = require __DIR__ . '/db.php';

$config = [
    'id' => 'basic',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'aliases' => [
        '@bower' => '@vendor/bower-asset',
        '@npm'   => '@vendor/npm-asset',
    ],
    'components' => [

        'mercado_pago' => require(__DIR__ . '/mercado_pago.php'),

        'request' => [
            // !!! insert a secret key in the following (if it is empty) - this is required by cookie validation
            'cookieValidationKey' => 'wwwKdGYigglQUNwdITMbYYGunRySDRep',
        ],
        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],
        'user' => [
            'identityClass' => 'app\models\admin\User',
            'enableAutoLogin' => true,
            'authTimeout' => (60 * 60),
        ],
        'errorHandler' => [
            'errorAction' => 'site/error',
        ],
        'mailer' => [
            'class' => \yii\symfonymailer\Mailer::class,
            'viewPath' => '@app/mail',
            // send all mails to a file by default.
            'useFileTransport' => true,
        ],
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'db' => $db,
        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            'rules' => [],
        ],
        'authManager' => [
            'class' => 'yii\rbac\DbManager',
        ],


    ],
    'as access' => [
        'class' => AcessControlPagamento::class,
        'allowRotas' => [
            '/site/login',
            '/site/error',
            '/site/logout'
        ]


    ],
    'modules' => [
        'gridview' => ['class' => '\kartik\grid\Module']
    ],
    'defaultRoute' => 'perfil/perfil-user',
    'params' => $params,
];

if (YII_ENV_DEV) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][] = 'debug';
    $config['modules']['debug'] = [
        'class' => 'yii\debug\Module',
        // uncomment the following to add your IP if you are not connecting from localhost.
        //'allowedIPs' => ['127.0.0.1', '::1'],
        'allowedIPs' => ['*']
    ];

    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
        // uncomment the following to add your IP if you are not connecting from localhost.
        //'allowedIPs' => ['127.0.0.1', '::1'],
        'allowedIPs' => ['*'],
        'generators' => [ //here
            'crud' => [ // generator name
                'class' => 'yii\gii\generators\crud\Generator', // generator class
                'templates' => [ //setting for out templates
                    'myCrud' => '@app/templates/default', // template name => path to template
                ]
            ]
        ],
    ];
}

return $config;
