#Rodar com cuidado esse arquivo
#!/bin/sh
cd terraform/ ; terraform init >/dev/null 2>&1
echo 'Olá, Você realmente deseja apagar sua infraestrutura montada [S/N]?'
read escolha

if [ $escolha == S ]
then
    echo 'Desmontando Infraestrutura'
    terraform destroy --auto-approve ; echo [webserver] > ../ansible/hosts
exit 3

else
    echo 'Encerrando...'
exit 3
fi