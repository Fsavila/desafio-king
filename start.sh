#!/bin/sh

echo 'Olá seja bem vindo!'
echo ''
echo 'Fique tranquilo, estarei realizando os procedimentos para você.'
sleep 1

echo 'Iniciando Terraform'
cd ./terraform
terraform apply --auto-approve
sleep 5

echo 'Iniciando Ansible'
cd ../ansible/ ; ansible-playbook -i hosts main.yml -u bruno -b
sleep 1

echo 'Pronto Finalizando Stage'
echo ''
echo 'Seu Container do GitLab está rodando no endereço ip_da_vm:5000'
echo ''
echo 'Para obter a senha root do Gitlab, basta rodar o comando: sudo docker exec gitlab cat /etc/gitlab/initial_root_password'
sleep 3

echo 'Obrigado!'