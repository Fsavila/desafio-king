#!/bin/sh
echo 'Instalando Terraform'
sleep 2
sudo apt-get -y update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get -y update && sudo apt-get -y install terraform

terraform --version > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "Terraform Instalado..."
    terraform --version
    sleep 2
else
    echo "Ops, Algo deu errado"
    exit 3
fi    

echo 'Instalando Ansible'
sleep 2
sudo apt update -y
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

echo ""

ansible --version > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "Ansible Instalado..."
    ansible --version
    sleep 2
else
    echo "Ops, Algo deu errado"
    exit 3
fi

echo "Pronto para avançarmos ao stage de test"