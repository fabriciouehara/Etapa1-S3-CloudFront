1) Logar na conta da amazon e criar um usuario administrativo do tipo programer, e salvar o access key e secret key

2) configurar o arquivo variables.tf com os valores do passo anterior.

3) Baixar o binario do terraform

4) Navegar para dentro do diretorio pelo cmd

5) instalar plugin do aws terraform:
terraform.exe init

6) Rodar o comando abaixo para verificar as mudanças na infraestrutura:
terraform.exe plan

7) Rodar o terraform:
terraform.exe apply -auto-approve 

8) Verificar a criação do site estatico no bucket s3 atraves da url:
http://buckets3-terraform-fabricio.s3-website-us-east-1.amazonaws.com/

9) Verificar a criação do site estatico na distribuição do CloudFront:
Logar na amazon, e abrir o dominio do cloudfront referente ao origin 'buckets3-terraform-fabricio.s3.amazonaws.com'

