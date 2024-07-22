<p align="center">
    <h1 align="center">Pagamento Yii2</h1>
    <br>
</p>

O Pagamento yii2 é um exemplo de como integrar o framework yii2 com a API de mercado Pago.
Nesse caso de usos mostra um sistema de controle de conteúdo , em que cada plano de assinatura 
representa uma permissão de acesso a conteúdo deferente.

 ## Arquitetura de Containers 
 
 Descrições dos containers:
   - <b>apache</b>: Servidor web, utilizando o sistema apache.
   - <b>app</b>: PHP 8 com os códigos do sistema
   - <b>db_invest</b>: Banco de dados do sistema com o Postgresql instalado
   
 ## Pré-requisito
   - Git
   - Docker
   - Docker-compose

## Tecnologias utilizadas

- ``PHP 8.2``
- ``Yii2``
- ``PostgresSql``
- ``JavaScript``
- ``Extensão gd para redimencionar foto``
- ``API mercado pago``
- ``RBAC Yii2``
  

    
 ## Instalação

  Baixar o projeto no github.
 ~~~
 https://github.com/henrique-r-luz/pagamentoYii2.git
 ~~~ 
 Após a conclusão do download entre na pasta pagamentoYii2 e execute o comando abaixo.
 Esse processo pode levar alguns minutos porque o docker irá criar e configurar
 cada container. 
 ~~~
 sudo docker-compose up
 ~~~ 
 Com os contêineres ligados, acesse o app com o seguinte comando:
 ~~~
sudo docker exec -it pagamentoyii2_app_1  bash
 ~~~
 Execute o compose para instalar as dependências
 ~~~
 composer install
 ~~~
 Depois execute os migrates 
 ~~~
php yii migrate
 ~~~
 Crie uma conta no mercado pago developer pelo site: https://www.mercadopago.com.br/developers/pt
 
 ![Screenshot 2024-07-22 at 14-24-02 Mercado Pago Developers](https://github.com/user-attachments/assets/761ee979-a4ac-4906-8678-7ae8de485b9e)

 Cria as contas de vendedor e comprador , na conta de vendedor você pode recuperar o acess_token e o public_key 
 
![Captura de tela de 2024-07-22 14-35-25](https://github.com/user-attachments/assets/102195a5-3a56-4da8-beaf-188e108129de)

 Crie o arquivo de configuração do mercado pago, config/mercado_pago.php
 ~~~
return [
    'class' => MercadoPago::class,
    'url' => 'https://api.mercadopago.com/',
    'token' => "acess_token",
    'cliente' => "public_key"
];
 ~~~
