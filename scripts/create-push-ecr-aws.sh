#!/bin/bash

# Defina as variáveis
aws_account_id=$(aws configure get region)
repository_name="producao"
tag="v1"
image_id=$(docker images -q | head -n 1)
region=$(aws sts get-caller-identity --query "Account" --output text)

# Crie o nome completo da imagem no ECR
ecr_image="${aws_account_id}.dkr.ecr.${region}.amazonaws.com/${repository_name}:${tag}"

# Execute o comando docker tag
docker tag ${image_id} ${ecr_image}

# Exiba a imagem recém-tagged
echo "Imagem Docker foi tagueada como: ${ecr_image}"

# Faça o push da imagem para o Amazon ECR
docker push ${ecr_image}

# Exiba mensagem de conclusão
echo "Imagem Docker foi enviada para o Amazon ECR com sucesso!"