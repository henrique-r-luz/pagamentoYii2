<?php

use yii\helpers\Url;
use app\models\admin\PlanoTipo;

$this->registerJsFile('https://sdk.mercadopago.com/js/v2', ['position' => \yii\web\View::EVENT_BEGIN_BODY]);
$create =  '<a href="' . Url::to(['seleciona-plano']) . '" class="btn btn-secondary btn-icon-split ml-auto">
<span class="icon text-white-50">
    <i class="fas fa-arrow-left"></i>
</span>
<span class="text">Voltar</span>
</a>'
?>
<div class="card shadow mb-4">
    <div class="card-header d-flex py-3">
        <h6 class="m-0 font-weight-bold text-primary"><?= $planoTipo->nome ?></h6>
        <?= $create ?>
    </div>
    <div class="card-body">
        <p>
            O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro. Este texto não só sobreviveu 5 séculos, mas também o salto para a tipografia electrónica, mantendo-se essencialmente inalterada. Foi popularizada nos anos 60 com a disponibilização das folhas de Letraset, que continham passagens com Lorem Ipsum, e mais recentemente com os programas de publicação como o Aldus PageMaker que incluem versões do Lorem Ipsum.
        </p>
    </div>
</div>
<div class="card border-left-success shadow h-100 py-2">
    <div class="card-body">
        <div id="cardPaymentBrick_container"></div>
    </div>
</div>
<script>
    const mp = new MercadoPago('APP_USR-45b1095b-131c-4eee-8daf-3fc00b0502b6');
    const bricksBuilder = mp.bricks();
    const renderCardPaymentBrick = async (bricksBuilder) => {
        const settings = {
            initialization: {
                amount: <?= $planoTipo->planoDescricao->valor_plano ?>, // valor total a ser pago
                payer: {
                    email: "<?= $pessoa->email ?>",
                    identification: {
                        "type": "CPF",
                        "number": "<?= $pessoa->cpf ?>",
                    },
                },
            },
            customization: {
                visual: {
                    style: {
                        customVariables: {
                            theme: 'bootstrap', // | 'dark' | 'bootstrap' | 'flat'
                        }
                    }
                },
                paymentMethods: {
                    types: {
                        excluded: ['debit_card']
                    },
                    maxInstallments: 1,
                }
            },
            callbacks: {

                onReady: () => {
                    // callback chamado quando o Brick estiver pronto
                },
                onSubmit: (cardFormData) => {
                    //  callback chamado o usuário clicar no botão de submissão dos dados
                    //  exemplo de envio dos dados coletados pelo Brick para seu servidor
                    cardFormData.plano_id = <?= $planoTipo->id ?>;
                    return new Promise((resolve, reject) => {
                        fetch("/perfil/assinatura-cliente/pagamento", {
                                method: "POST",
                                headers: {
                                    "Content-Type": "application/json",
                                },
                                body: JSON.stringify(cardFormData)
                            })
                            .then((response) => {
                                // receber o resultado do pagamento
                                window.location.href = '<?= Yii::$app->homeUrl ?>';
                                console.log(response);

                            })
                            .catch((error) => {
                                // lidar com a resposta de erro ao tentar criar o pagamento
                                reject();
                            })
                    });
                },
                onError: (error) => {
                    console.log('erroooo');
                    // callback chamado para todos os casos de erro do Brick
                },
            },
        };
        window.cardPaymentBrickController = await bricksBuilder.create('cardPayment', 'cardPaymentBrick_container', settings);
    };
    renderCardPaymentBrick(bricksBuilder);
</script>