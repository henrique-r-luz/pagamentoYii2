<?php

use yii\helpers\Url;
use yii\helpers\Html;
use app\lib\ActionColumnPadrao;
use app\lib\GridViewPadrao as GridView;
use app\lib\dicionario\StatusAssinatura;

?>

        <?= GridView::widget([
            'titulo' => 'Históricos de Planos',
            'dataProvider' => $dataProvider,
            'filterModel' => $searchModel,
            'create' =>  '<a href="' . Url::to(['/perfil/assinatura-cliente/seleciona-plano']) . '" class="btn btn-primary btn-icon-split ml-auto">
            <span class="icon text-white-50">
                <i class="fas fa-plus"></i>
            </span>
            <span class="text">Assinar</span>
        </a>',
            'columns' => [
                [
                    'attribute' => 'id',
                    'options' => ['style' => 'width:5%;'],
                ],
                'user_nome',
                'plano_nome',
                [
                    'attribute' => 'data_inicio',
                    'format' => ['date', 'php:d/m/Y H:i:s'],

                ],
                [
                    'attribute' => 'data_fim',
                    'format' => ['date', 'php:d/m/Y H:i:s'],

                ],
                [
                    'header' => 'Ações',
                    'class' => ActionColumnPadrao::class,
                    'template' => '{cancelar}',
                    'buttons' => [
                        'cancelar' => function ($url, $model, $key) {
                            return Html::a('<i class="fas fa-ban"  style="color: #c01c28;"></i>', $url, [
                                'title' => 'Cancelar',
                                //'data-pjax' => '0',
                                'data-confirm' => 'Tem certeza que deseja cancelar a Assinatura?',
                                'data-method' => 'post',
                            ]);
                        },
                    ],
                    'visibleButtons' => [
                        'cancelar' => function ($model, $key, $index) {

                            return $model->status == StatusAssinatura::AUTHORIZED; // Show 'view' button only for active users
                        },

                    ],
                    'options' => ['style' => 'width:6%;']
                ],
            ],
        ]); ?>
