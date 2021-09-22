##			Desafio KingHost - Analista de Infraestrutura de Hosting Linux

### Objetivo

O projeto  faz parte do desafio KingHost para seleção de Analista de Infraestrutura de Hosting Linux.
Nesse projeto busquei apresentar meu nível de conhecimento de cultura DevOps e tecnologias focadas em IaaC(Infra as Code),
Configuration Management, CI/CD, Clean Code e Clean Architecture.

### Instruções

Para realizar o deploy da infraestrutura elaborada, é necessário cumprir alguns requisitos:

- Conta  ativa no GCP
- Realizar Download das credenciais de acesso do GCP em formato .json(Salvar em terraform/credentials.json)
- Possuir Terraform instalado (https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Possuir Ansible instalado (https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

Após realizadas as verificações dos requisitos podemos avançar para realizar o deploy do projeto, na raiz do projeto 
você irá encontrar o arquivo responsável pela execução de toda a infraestrutura(*start.sh*). Para executar, primeiramente você deverá ajustar as permissões do arquivo, atribuindo permissão  para ele se tornar um executável(*chmod +x start.sh*). Feito isso basta executar(*./start.sh*). Assim sua infraestrutura será montada em poucos minutos.

### Tecnologias Utilizadas

- Ansible: A escolha do Ansible se deu por ser atualmente uma das ferramentas de provisionamento mais conceituadas no mundo DevOps, além disso possui documentação sólida, comunidade ativa, linguagem YAML(Fácil interpretação do código), multiplataforma e também bom funcionamentos com orquestradores(Docker, Kubernetes, e etc...);
- Docker: Como um dos requisitos era a conteinerização do GitLab decidi utilizar o Docker como plataforma de conteinerização, por possuir também uma comunidade ativa e boa documentação, além de ser possível trabalhar com Kubernetes, caso necessário a expansão do projeto e houver a necessidade de utilizar Clusters;
- Google Cloud Plataform: Utilizei a GCP por já ter conhecimento da plataforma, além de possuir uma melhor performance em relação a AWS nas opções Free, outro fator importante é a sua facilidade de utilização até mesmo para quem detem pouco conhecimento em Provider;
- Terraform: Optei por utilizar o Terraform nesse projeto para provisionar a infraestrutura.Os principais motivos que fizeram eu optar por essa ferramenta, foram: Documentação e comunidade ativa, Amplo suporte em diversos provedores como: AWS, Azure, GCP, OpenStack, etc. Ser Idempotente, eu posso aplicar diversas vezes o código e nenhuma alteração será feita, a menos que eu tenha realizado alguma alteração. Modularização em seu código(Possibilitando utilizar em outros projetos) e Possibilidade de verificar o plano de execução antes dele realmente ser executado(Auxilia na prevenção de problemas na Infraestrutura).

### Tomada de Decisões

<img src = "https://github.com/bramos013/desafio-king/blob/main/images/kanban.png" width = "50px" />

Primeiramente decidi utilizar um Kanban para a elaboração do plano de execução do projeto, visto que não detinha conhecimento de algumas tecnologias, evitar riscos em falhas nos processos e também ter um melhor controle no prazo de entrega. Assim que realizado o planejamento avancei na escolhas das tecnologias e ferramentas a utilizar. Nesse momento tive alguns impasses na escolha do provisionador, no inicio pensei em utilizar o SaltStack no qual atualmente é utilizado na KingHost, porém estudando o seu funcionamento optei por não utilizar pois verifiquei que ele é uma plataforma mais complexa, com uma documentação não tão sólida comparada a outras opções de mercado. Também como se trata de um projeto com curto prazo de entrega, optei por ferramentas mais consolidadas, documentação sólida e com uma baixa curva de aprendizado.

<img src = "https://github.com/bramos013/desafio-king/blob/main/images/gitlab.png" width = "50px" />











