#!/bin/bash

# Array de regiões a serem verificadas
regions=(
    "us-east-1"
    "us-east-2"
    "us-west-1"
    "us-west-2"
    "eu-west-1"
    "eu-central-1"
    "ap-southeast-1"
    "ap-southeast-2"
    "ap-northeast-1"
    "ap-northeast-2"
    "sa-east-1"
    # Adicione mais regiões conforme necessário
)

# Iterar sobre cada região e listar ENIs
for region in "${regions[@]}"; do
    echo "Verificando ENIs na região: $region"
    aws ec2 describe-network-interfaces --region $region
    echo "----------------------------------------"
done
