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
)

# Função para verificar clusters EKS
check_eks_clusters() {
    for region in "${regions[@]}"; do
        echo "Verificando clusters EKS na região: $region"
        clusters=$(aws eks list-clusters --region "$region" --query "clusters" --output text)
        if [ -n "$clusters" ]; then
            echo "Clusters EKS encontrados na região $region:"
            echo "$clusters"
        else
            echo "Nenhum cluster EKS encontrado na região $region."
        fi
        echo "----------------------------------------"
    done
}

# Função para verificar clusters EMR (Elastic MapReduce)
check_emr_clusters() {
    for region in "${regions[@]}"; do
        echo "Verificando clusters EMR na região: $region"
        clusters=$(aws emr list-clusters --active --region "$region" --query "Clusters[*].Id" --output text)
        if [ -n "$clusters" ]; then
            echo "Clusters EMR encontrados na região $region:"
            echo "$clusters"
        else
            echo "Nenhum cluster EMR encontrado na região $region."
        fi
        echo "----------------------------------------"
    done
}

# Verificar clusters em diferentes serviços
echo "Verificando clusters em execução nas regiões especificadas..."
check_eks_clusters
check_emr_clusters
