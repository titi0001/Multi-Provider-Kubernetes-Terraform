#!/bin/bash

# Executa o comando docker images e extrai apenas os nomes dos repositórios
nomes_dos_repositorios=$(docker images --format "{{.Repository}}:{{.Tag}}")

# Define a parte numérica inicial com até 12 números
numeros_iniciais="[a-z0-9-]{1,50}"
tag="[a-z0-9-]{1,50}"

# Define o formato do nome da imagem que deseja verificar
formato_da_imagem="${numeros_iniciais}\.dkr\.ecr\.us-west-2\.amazonaws\.com/[a-zA-Z]+:${tag}"

# Cria um regex que corresponda ao formato da imagem
regex="^${numeros_iniciais}\.dkr\.ecr\.us-west-2\.amazonaws\.com/[a-zA-Z]+:${tag}$"

# Flag para indicar se uma imagem correspondente foi encontrada
imagem_correspondente_encontrada=false

# Loop sobre os nomes dos repositórios
while read -r nome_do_repositorio; do
    # Verifica se o nome do repositório corresponde ao regex
    if [[ "$nome_do_repositorio" =~ $regex ]]; then
        imagem_correspondente_encontrada=true
        echo "Imagem correspondente encontrada: $nome_do_repositorio"
        # Adicione aqui qualquer ação adicional que deseja executar para uma imagem correspondente
        # Faça o push da imagem para o Amazon ECR
        docker push ${nome_do_repositorio}
        # Exiba mensagem de conclusão
        echo "Imagem Docker foi enviada para o Amazon ECR com sucesso!"
    fi
done <<< "$nomes_dos_repositorios"

# Verifica se pelo menos uma imagem correspondente foi encontrada
if [ "$imagem_correspondente_encontrada" = false ]; then
    echo "Nenhuma imagem correspondente foi encontrada."
fi
