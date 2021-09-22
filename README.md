# Projeto de Infra as Code

O projeto tem a lição de mostrar que é possível fazer uma infra totalmente programavel, evitando passos manuais para facilitar a entrega de uma infraestrutura ágil e de facil entendimento.

Todos os recursos usados foram baseados na percepção de melhor estratégia para o desafio e pensando em expandir não apenas ao que foi pedido mas que com uma pequena mudança pode atender outras features.


## Quais ferramentas foram utlizadas e porque o uso destas?

**° Terraforms**: Dentre todos os gerenciadores para criação de instancias o terraforms foi o mais amigavel e de facil utilização. O que mais me motivou em usar ele foi a vasta documentação que possúi e a comunidade ser ativa tendo assim respostas para muitas das duvidas que tive dentro do processo alem de ser uma ferramenta muito simples e de facil entendimento.

**° Ansible**: Antes de usar o ansible eu pesquisei outras ferramentas pois queria ser um pouco diferente mas vi que muitas delas não atenderiam o proposito deste processo. (Vangrant, puppet... etc). Diferente dessas outras duas o Ansible tem uma capacidade de fazer todas as tarefas de forma muito simples. Num teste que fiz eu subi cerca de 15 maquinas ao mesmo tempo aonde o ansible configurou todas padronamente e ao mesmo stage de tempo para cada tarefa. A organização e simplicidade foi o que me fez optar por usar ele.

**° GCP**: Primeira vez que trabalhei com GCP é simplesmente incrivel a infraestrutura deles. Painel completo, muita doc por parte não só da google mas com a comunidade não tem como tu passar sufoco usando essa plataforma.

**° Docker**: Acredito que não exista sistema melhor que o docker hoje em dia para container. Como todas as outras opções  alem da super compatibilidade que possui já integrado com as outras ferramentas como (Ansible e o Nginx) não poderia optar por outro a não ser ele.

**° Nginx**: Efetuei a configuração do nginx em todas as instancias, para fazer a melhor manobra do proxy com uso das portas disponiveis dentro do ambiente. Alem de ser um excelente webserver a facil integração com docker facilitou muito a utilização da estrutura.



#Como vamos usar este projeto:

### Pré-requisitos:


- Com sua conta GCP criada, faça a criação de um novo Projeto.
- Na barra de pesquisa procure por "Contas e Serviços". Crie uma conta de serviço para esse projeto delegando o Papel de Adminstrador.
- Gere a chave no tipo JSON para a conta e substitua o conteúdo do codigo-acesso-gcp.json pelo gerado no painel do gcp.
![image](https://user-images.githubusercontent.com/54381653/134224104-9649e06e-5fd4-43e5-9042-6e2251f6326a.png)
- Adicione o ID do seu projeto no arquivo variables.tf ![image](https://user-images.githubusercontent.com/54381653/134226145-250fb684-c5dc-4d72-9279-a73b62a0b9ca.png)
- Criar uma chave publica SSH para seu usuario lembre de deixar ela no caminho: ~/.ssh/id_rsa.pub
- Altere o usuario correspondente ao seu no arquivo main.tf ssh-keys = "anderson:${file("~/.ssh/id_rsa.pub")}"

 
 
 ## Certo tudo preparado como prosseguir?
 
 Para que possamos dar continuidade  no projeto você deverá fazer o seguinte:
 
 1) inicie o script ./init-deploy.sh
 2) Enquanto o script estiver rodando algumas informações vão retornar na sua tela, uma delas é a senha do ROOT do GitLab que foi feito deploy
 3) Antes de apertar para continuar certifiquesse que o acesso esta funcional da estrutura lembrando que o acesso ao gitlab é ataves ip:8080 (Pode demorar um pouco para que fique pronto o gitlab basta aguardar uns 3 minutinhos pois o docker demora para fazer o download da imagem) 
 4) Acesse o gitlab com sua senha do root e crie um novo projeto ponha qualquer nome nele.
 5) Clique em Settings a baixo do projeto e após isso em CI/CD > Runner
 6) ![image](https://user-images.githubusercontent.com/54381653/134230044-1e9b6c53-490a-462d-af01-97ea93adf9ce.png) OBS: Essas infomações já não existem mais.
 7) Com estes dados será necessário cadastrar o Runner para que o gitlab execute os scripts no novo ambiente.
 8) No arquivo gitlab-runner.yml troque as informações como URL e registration token que estão destacadas com os nomes $URL E $TOKENREG. --url --clone-url --registration-token
 9) Pronto agora ele vai terminar de depoylar por completo. A estrutura nesse momento se encontra toda pronta.
 10) Para finalizar o Projeto agora iremos copiar o nosso arquivo gitlab-ci.yml la no editor de criação de pipeline do CI/CD feito isso basta dar run na pipeline e se tudo der certo ele irá refazer um novo deploy na estrutura.
 OBS:![image](https://user-images.githubusercontent.com/54381653/134264897-cf36b2b1-9a3b-41bb-9545-c0f5e732c291.png)

Crie essas 3 variaveis no CI/CD contendo somente os seguintes conteúdos:

- ACESSO_KEY_GCP: conteúdo do json do arquivo codigo-acesso-gcp.json
- REGISTRATION_KEY: A key de acesso ao Runner (Do RUNNER do projeto, não do runner global)
- URL_RUNNER: O ip do gitlab sendo assim o value ficará apenas com IPDOSERVIDOR:8080

FEITO TUDO RUNPIPELINE E ABRAÇO!
Concluído!



# Conclusão

Embora tenha feito o ambiente em 2 containers a estutura que foi criada com o projeto ela pode ser usada em larga escala com algumas alterações. Isto se deve a versatilidade das ferramentas utilizadas e simplicidade em se trabalhar com o GCP.

Lembrando que isso é apenas um teste com container, o cenario ideal sera apenas 1 docker com o gitlab em seu funcionamento, e os runners em diversas instancias diferentes e assim provendo apenas de uma unica key e host evitando qualquer processo manual futuro. Tendo assim de ser realizado apenas na primeira vez que utiliza o deploy!.

Caso queiram Ver outras maneiras de como externas mais instancias me manda um contato que ensino como fazer! :D



Duvidas?: anderdgs@outlook.com
