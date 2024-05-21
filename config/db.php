<?php

return [
    'class' => 'yii\db\Connection',
    'dsn' => 'pgsql:host=db_pagamento;dbname=pagamento',
    'username' => 'postgres',
    'password' => 'pagamento',
    'charset' => 'utf8',

    // Schema cache options (for production environment)
    //'enableSchemaCache' => true,
    //'schemaCacheDuration' => 60,
    //'schemaCache' => 'cache',
];
