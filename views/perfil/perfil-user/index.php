<?php



?>
<div class="row">
    <div class="col-xl-4 col-lg-4">
        <?= $this->render(
            'dadosPessoais',
            [
                'model' => $model
            ]
        ) ?>
    </div>
    <div class="col-xl-8 col-lg-8">
        <?= $this->render('plano', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider
        ]) ?>
    </div>
</div>