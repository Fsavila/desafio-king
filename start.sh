#!/bin/sh

USER = "usuario" # Alterar para o usuário do seu computador

echo 'Olá seja bem vindo!'
echo ''
echo 'Fique tranquilo, estarei realizando os procedimentos para você.'
sleep 1

echo 'Iniciando Terraform'
cd terraform/ ; terraform init >/dev/null 2>&1 ; terraform apply --auto-approve
sleep 5

echo 'Iniciando Ansible'
cd ../ansible/ ; ansible-playbook -i hosts main.yml -u $USER -b
sleep 5

echo 'Obrigado!'