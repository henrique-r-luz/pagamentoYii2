<?php



?>
<div class="row">
    <div class="col-xl-4 col-lg-4">
        <?= $this->render(
            'dadosPessoais',
            [
                'user' => $user
            ]
        ) ?>
    </div>
    <div class="col-xl-4 col-lg-4">
        <?= $this->render('plano', []) ?>
    </div>
</div>