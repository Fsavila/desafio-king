#!/bin/bash


# Limpa o hosts para evitar qualquer conflito.
# Lembre de que caso troque o nome da ROLE das instancias deve ser alterado aqui também no ECHO.

> ./hosts

echo -e "[vminfra]" >> ./hosts

# Como apenas é para testes, uso do destroy é para remover qualquer instancia criada e evitar cobranças desnecessárias
# Descomente apenas em caso de testes.


# -- terraform destroy

terraform init

sleep 3


# Deploy das Instancias.

terraform apply -auto-approve
sleep 15

# Instalações com Ansible.
export ANSIBLE_HOST_KEY_CHECKING=False;
ansible-playbook ./ansible/provisoning.yml -i ./hosts

# Pra facilitar a vida de voces a nova versão do gitlab ja vem com uma senha padrão do root/Admin.
# Sendo assim esse playbook serve apenas para entrar na instancia do gitlab-ce e trazer essa info pra vocês :D
echo "Pegando a senha do usuario: root do gitlab-ce"
echo ""
ansible-playbook ./ansible/rootglab-ce.yml -i hosts -v | grep -oe "Password:............................................."

echo ""
echo "Gitlab-ce estará disponivel na porta IPDAINSTANCIA:8080"

echo "LEMBRE DE TERMINAR OS PASSO 8 ANTES DE CONTINUAR" 
echo ""
echo "Aperte a tecla enter para continuar"
read -p "" vazio

ansible-playbook ./ansible/permissions.yml -i hosts
ansible-playbook ./ansible/gitlab-runner.yml -i hosts


echo "Simples né? :D"
