<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Dados Pessoais</h6>
    </div>
    <div class="card-body  text-center">
        <div class="text-center">
            <img class="img-fluid rounded-circle border border-primary" src="img/profile.png">
        </div>
        <hr style="border-top: 2px solid #007bff;">
        <div class="mb-1 text-gray-800">
            <p><strong>Nome: <?= $user->pessoa->nome ?></strong></p>
            <p><strong>CPF: <?= $user->pessoa->cpfFormat() ?></strong></p>
            <p><strong>Email: <?= $user->pessoa->email ?></strong></p>
        </div>
        <hr style="border-top: 2px solid #007bff;">
        <a target="_blank" rel="nofollow" href="https://undraw.co/">Editar Perfil</a>
    </div>
</div>