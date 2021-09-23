# Projeto de Infra as Code

O projeto tem a lição de mostrar que é possível fazer uma infra totalmente programavel, evitando passos manuais para facilitar a entrega de uma infraestrutura ágil e de facil entendimento.

Todos os recursos usados foram baseados na percepção de melhor estratégia para o desafio e pensando em expandir não apenas ao que foi pedido mas que com uma pequena mudança pode atender outras features.

O projeto terá 2 containers para melhor uso das ferramentas listadas a baixo, optei por fazer desta forma pois o duckerhub possuí as imagens já prontas para o que eu necessito. Afinal já foi o tempo de instalar tudo na mão não é mesmo?

Separei cada arquivo para que ficasse de melhor entendimento durante o processo. Inclusive adicionei um script para que execute todos os passos de forma segura sem erros, isso trará melhor confiabilidade na hora da execução (e  também para iniciar o processo no gitlab.)

Foram utilizados servidores com 2 nucleos de CPU e 8Gb de ram para atender a demanda dos dockers.

OBS: Se atente aos comentários dos arquivos, em cada um deles existem explicações claras sobre o que cada parte faz e porque foram utilizadas daquela maneira.

## Estrutura do Projeto:

Como podem ver no fluxograma localmente, rodamos apenas uma unica vez o script e assim  geramos a primeira instancia que contem 2 containeirs.

1 Gitlab CI/CD que irá gerar as pipelines e 1 Container Runner que irá executar o projeto, e refazer o deploy do projeto novamente e assim de dentro do runner gerando mais 1 instancia de vm com mais 2 dockers contendo a mesma estrutura da instancia inciial.

**OBS: Aqui vocês vao notar que apenas o gitlab "pai" é quem vai ser usado. Todos os runners filhos vão ser dependentes deste gitlab "pai", sendo assim  toda pipeline executada dentro desse gitlab "pai" irá repassar aos runners filhos, netos, bisnetos e assim sucessivamente  e em quantos servidores eu criar.**

Os outros gitlabs CI/CD só existem porque fazem parte de criação do projeto, tirando o gitlab pai o resto destes gitlabs todos poderiam ser decartados mas mantive para mostrar que o processo continuo e ilimitado até acabar os recursos do teu provedor.

**Sendo assim após a primeira instancia criada com o script e os deploy ter sido concluido todas as outras instancias podem ser geradas exclusivamente pelo gitlab progenitor sem ter que executar qualqur script localmente.**




![image](https://user-images.githubusercontent.com/54381653/134443653-d72ab993-215a-46d5-a90e-cd3292c5e157.png)
## Quais ferramentas foram utlizadas e porque o uso destas?

**° Terraforms**: Dentre todos os gerenciadores para criação de instancias o terraforms foi o mais amigavel e de facil utilização. O que mais me motivou em usar ele foi a vasta documentação que possúi e a comunidade ser ativa tendo assim respostas para muitas das duvidas que tive dentro do processo alem de ser uma ferramenta muito simples e de facil entendimento.

**° Ansible**: Antes de usar o ansible eu pesquisei outras ferramentas pois queria ser um pouco diferente mas vi que muitas delas não atenderiam o proposito deste processo. (Vangrant, puppet... etc). Diferente dessas outras duas o Ansible tem uma capacidade de fazer todas as tarefas de forma muito simples. Num teste que fiz eu subi cerca de 15 maquinas ao mesmo tempo aonde o ansible configurou todas padronamente e ao mesmo stage de tempo para cada tarefa. A organização e simplicidade foi o que me fez optar por usar ele.

**° GCP**: Primeira vez que trabalhei com GCP é simplesmente incrivel a infraestrutura deles. Painel completo, muita doc por parte não só da google mas com a comunidade não tem como tu passar sufoco usando essa plataforma.

**° Docker**: Acredito que não exista sistema melhor que o docker hoje em dia para container. Como todas as outras opções  alem da super compatibilidade que possui já integrado com as outras ferramentas como (Ansible e o Nginx) não poderia optar por outro a não ser ele.

**° Nginx**: Efetuei a configuração do nginx em todas as instancias, para fazer a melhor manobra do proxy com uso das portas disponiveis dentro do ambiente. Alem de ser um excelente webserver a facil integração com docker facilitou muito a utilização da estrutura.



# Como vamos usar este projeto:

### Pré-requisitos:


- Com sua conta GCP criada, faça a criação de um novo Projeto.
- Na barra de pesquisa procure por "Contas e Serviços". Crie uma conta de serviço para esse projeto delegando o Papel de Projeto > Proprietario.
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
 9) **Pronto agora pode clicar em qualquer tecla que ele vai terminar de depoylar por completo. A estrutura nesse momento se encontra toda pronta.**
 10) Para finalizar o Projeto agora iremos copiar o nosso arquivo gitlab-ci.yml la no editor de criação de pipeline do CI/CD. Cole a pipeline desenvolvida la.

 **OBS:**
 
 ![image](https://user-images.githubusercontent.com/54381653/134449446-ab18c3b4-78f1-4e2e-a875-e0e2eecb1f8f.png)


Crie essas 4 variaveis no CI/CD contendo somente os seguintes conteúdos:

- **ACESSO_KEY_GCP: conteúdo do json do arquivo codigo-acesso-gcp.json**
- **REGISTRATION_KEY: A key de acesso ao Runner (Do RUNNER do projeto, não do runner global)**
- **URL_RUNNER: O ip do gitlab sendo assim o value ficará apenas com IPDOSERVIDOR:8080**
- **ID_PROJECT_GPC: contendo o nome do seu idPorojeto do projeto criado no painel do GCP**


Após cadastrar as variaveis basta voltar no editor, e clicar em commit changes.
Pronto! 

Uma nova isntancia será criada automaticamente sempre que você rodar uma nova pipeline, lembrando que cada instancia possui um runner cadastrado interligado com este gestor de codigo no caso o gitlab aonde tu executou a pipeline. sendo assim qualquer escript que for executa nesse gitlab será repassado a todos os runners criados a partir deste código de deploy.


Concluído!



# Conclusão

Embora tenha feito o ambiente em 2 containers a estutura que foi criada com o projeto ela pode ser usada em larga escala com algumas alterações. Isto se deve a versatilidade das ferramentas utilizadas e simplicidade em se trabalhar com o GCP.

Lembrando que isso é apenas um teste com container, o cenario ideal sera apenas 1 docker com o gitlab em seu funcionamento, e os runners em diversas instancias diferentes e assim provendo apenas de uma unica key e host evitando qualquer processo manual futuro. Tendo assim de ser realizado apenas na primeira vez que utiliza o deploy!.

Caso queiram Ver outras maneiras de como externas mais instancias me manda um contato que ensino como fazer! :D



Duvidas?: anderdgs@outlook.com
