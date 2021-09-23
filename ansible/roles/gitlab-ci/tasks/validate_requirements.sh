#!/bin/sh

echo 'Realizando verificações de requisitos!'
echo ''

terraform --version > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "Terraform Instalado..."
    terraform --version
    sleep 2
else
    echo "Que pena! Você não possui o Terraform instalado, para instalar visite o README, disponibilizei um link para facilitar a instalação"
    exit 3
fi    

ansible --version > /dev/null 2>&1

echo ""

if [ $? -eq 0 ]
then
    echo "Ansible Instalado..."
    ansible --version
    sleep 2
else
    echo "Que pena! Você não possui o Ansible instalado, para instalar visite o README, disponibilizei um link para facilitar a instalação"
    exit 3
fi

echo ""
echo "Parabéns, seu computador possui os requisitos técnicos"
sleep 3