<?php
$this->registerJsFile('https://sdk.mercadopago.com/js/v2', ['position' => \yii\web\View::EVENT_BEGIN_BODY]);
?>
<div id="cardPaymentBrick_container"></div>
<script>
    const mp = new MercadoPago('TEST-fd149d5a-c316-4a09-b01a-2ab85ac64f73', {
        locale: 'pt-BR'
    });
    const bricksBuilder = mp.bricks();
    const renderCardPaymentBrick = async (bricksBuilder) => {
        const settings = {
            initialization: {
                amount: <?= 5 ?>, // valor total a ser pago
                payer: {
                    email: "henrique@fkfk.com",
                    identification: {
                        "type": "CPF",
                        "number": "01909375560",
                    },
                },
            },
            customization: {
                visual: {
                    style: {
                        customVariables: {
                            theme: 'default', // | 'dark' | 'bootstrap' | 'flat'
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
                    return new Promise((resolve, reject) => {
                        fetch("/pagamento", {
                                method: "POST",
                                headers: {
                                    "Content-Type": "application/json",
                                },
                                body: JSON.stringify(cardFormData)
                            })
                            .then((response) => {
                                // receber o resultado do pagamento
                                resolve();
                            })
                            .catch((error) => {
                                // lidar com a resposta de erro ao tentar criar o pagamento
                                reject();
                            })
                    });
                },
                onError: (error) => {
                    // callback chamado para todos os casos de erro do Brick
                },
            },
        };
        window.cardPaymentBrickController = await bricksBuilder.create('cardPayment', 'cardPaymentBrick_container', settings);
    };
    renderCardPaymentBrick(bricksBuilder);
</script>