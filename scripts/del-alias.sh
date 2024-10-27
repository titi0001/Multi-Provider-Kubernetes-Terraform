#!/bin/bash

# Especifica a região desejada
REGION="us-west-2"

# Lista todos os aliases e armazena-os em uma variável, excluindo aliases gerenciados pela AWS
ALIASES=$(aws kms list-aliases --region $REGION --query 'Aliases[?AliasName!=`alias/aws/ebs` && AliasName!=`alias/aws/rds` && AliasName!=`alias/aws/redshift` && AliasName!=`alias/aws/s3` && AliasName!=`alias/aws/secretsmanager` && AliasName!=`alias/aws/ssm` && AliasName!=`alias/aws/xray`].AliasName' --output text)

# Verifica se a variável ALIASES está vazia
if [ -z "$ALIASES" ]; then
    echo "No aliases found in the region $REGION."
else
    # Itera sobre cada alias e deleta
    for ALIAS in $ALIASES
    do
        echo "Deleting alias: $ALIAS"
        aws kms delete-alias --alias-name $ALIAS --region $REGION
    done
fi
