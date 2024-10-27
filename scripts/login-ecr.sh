#!/bin/bash
# Defina as variáveis com suas informações
AWS_REGION=$(aws configure get region)
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
# Obtenha o token de login do Amazon ECR
DOCKER_LOGIN_COMMAND=$(aws ecr get-login-password --region $AWS_REGION)
# Execute o comando docker login
echo $DOCKER_LOGIN_COMMAND | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
