<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $name string */
/* @var $message string */
/* @var $exception Exception */

$this->title = $name;
?>
<section class="content">

    <!-- Begin Page Content -->
    <div class="container-fluid">
        <!-- 404 Error Text -->
        <div class="text-center">
            <div class="error mx-auto"><?= Html::encode($exception->statusCode ?? 500) ?></div>

            <p class="lead text-gray-800 mb-5"><?= Html::encode($exception->getMessage()) ?></p>
        </div>

    </div>
    <!-- /.container-fluid -->


</section>