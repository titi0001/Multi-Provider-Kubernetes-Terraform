#!/bin/bash

# Substitua 'SEU_NOME_DE_BUCKET' pelo nome desejado para o bucket
bucket_name='terraform-state-codingbr'
region=$(aws configure get region)  # Substitua pela região desejada

# Criação de um cliente S3
s3_client="aws s3api --region $region"

# Tenta criar o bucket
$s3_client create-bucket --bucket $bucket_name --create-bucket-configuration LocationConstraint=$region

# Verifica o código de saída do comando aws s3api
if [ $? -eq 0 ]; then
    echo "Bucket criado com sucesso"
else
    echo "Erro ao criar o bucket"
fi
