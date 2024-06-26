#!/bin/bash

# Script para listar os nomes dos repositórios ECR

# Execute o comando AWS CLI para obter a lista de repositórios
repositories=$(aws ecr describe-repositories --query 'repositories[*].repositoryName' --output json)

# Verifique se houve algum erro ao executar o comando
if [ $? -ne 0 ]; then
  echo "Erro ao obter a lista de repositórios."
  exit 1
fi

# Imprima os nomes dos repositórios
echo "Nomes dos repositórios ECR:"
echo "$repositories" | jq -r '.[]'

# Armazene os nomes dos repositórios em uma variável
repository_names=$(echo "$repositories" | jq -r '.[]')

# Escolha um repositório para excluir (substitua este exemplo pelo seu método de escolha)
read -p "Digite o nome do repositório que deseja excluir: "

# Verifique se o repositório escolhido está na lista de repositórios
if echo "$repository_names" | grep -q "$repository_name"; then
  # Execute o comando AWS CLI para excluir o repositório
  aws ecr delete-repository --repository-name "$repository_name" --force

  # Verifique se houve algum erro ao executar o comando
  if [ $? -ne 0 ]; then
    echo "Erro ao excluir o repositório."
    exit 1
  fi

  echo "Repositório ECR '$repository_name' excluído com sucesso."
else
  echo "O repositório '$repository_name' não está na lista de repositórios. Nenhum repositório foi excluído."
fi
