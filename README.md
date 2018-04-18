# Mini-app

O propósito desse repositório é de elaborar um Todo-list em Ruby on Rails. Esse Todo-list foi sugerido pela Autoseg para uma vaga de desenvolvedor Rails. O escopo da aplicação é o seguinte: [Mini-app.md](https://gist.github.com/githubas/0bf0c0c03fb1d243310356e019d3ff6f).

Escopos concluídos:

## Nível 1
 - [x] Usuário pode fazer Sign-up e Sign-in (autenticação) [é obrigatório o uso do Devise]
 - [x] Após logado, o usuário pode criar uma Lista de Tarefas
 - [x] No momento da criação de uma Lista já podemos criar várias Tarefas (usando nested attributes com javascript ou outro mecanismo de sua escolha).
 - [x] Cada lista pode ser "Pública" ou "Privada"
 - [x] O usuário criador da lista pode fechar uma tarefa
 - [x] O usuário logado pode ver listas públicas de outros usuários
 - [x] O usuário logado pode marcar uma lista pública de outro usuário como favorita
 - [x] O usuário logado pode ver todas as listas que ele marcou como favoritas

## Nível 2
### Subtarefa:
 - [] Lista de subtarefas em um nível
 - [] Lista de subtarefas deve ser acíclica
 - [] Se fechar todas as filhas, fecha o pai
 - [] Se fechar o pai, fecha as filhas
 - [] Apresentar de forma hierárquica as subtarefas

### Streaming de atualização:
 - [x] Criar uma estrutura de streaming de atualização (ou seja, informa o browser sem que seja necessário refresh de página) para indicar ao usuário com uma mensagem simples que alguma das listas públicas favoritas foi atualizada.

## Nível 3
  Não iniciado

## Todos os níveis
  - [x] Teste unitários(parcialmente completos)
  - [x] Teste de integração de no mínimo duas features com testes de integração usando RSpec + Capybara.
    - Features testadas:
      - Cada lista pode ser "Pública" ou "Privada"
      - O usuário logado pode ver listas públicas de outros usuários

## Pré-requisitos

### Instalação do Ruby on Rails

Antes de começar, tenha certeza que uma versão do Ruby >= 2.4.3 e o Rails 5

`$ ruby -v # ruby 2.4.3p205 (2017-12-14 revision 61247) [x86_64-linux]`

`$ rails -v # Rails 5.1.6`

Links de referência para instalação de ambos: [Setup RoR - GoRails](https://gorails.com/setup/ubuntu/17.10)

### Bundler

Bundler é um consistente gerenciador de dependências para projetos Ruby. Esse gerenciador é responsável por rastrear e instalar essas dependências de acordo com as versões necessárias para o projeto.

Ele é uma saida para da "dependency hell", e garante que as gems necessárias estejam presentes no ambiente de desenvolvimento, homologação e produção.
Para começar a trabalhar com um projeto com bundler basta somente rodar o comando `bundle install`.

Depois de instalado o Ruby rode o comando `gem install bundler` para instalação da gem do Bundler.

### Docker e Docker-compose

É possível buildar e rodar o projeto dentro de um container do [Docker](https://www.docker.com/). Com ele é possível que o projeto execute na máquina destino sem a necessidade de nenhum configuração de ambiente, como por exemplo, instalar Ruby, Rails e Bundler. Para isso basta ter o próprio Docker e [Docker-compose](https://docs.docker.com/compose/)(ferramenta do Docker para definir e rodar multiplas aplicações) instalado na máquina.

As diretrizes para instalação do Docker são essas: [Get Docker](https://www.docker.com/get-docker).

Obs: o Docker-compose está disponível ao instalar o Docker para os sistemas Windows e MacOS. Para usuários Linux precisa ser instalado separadamente. Basta seguir o link([Install Compose on Linux](https://docs.docker.com/compose/install/#install-compose)) clicando na aba "Install Compose > Linux" para instalar.

## Iniciando aplicação

### Manualmente com o `rails s`

Para isso abra o terminal, clone a aplicação utilizando o [Git](https://git-scm.com/book/pt-br/v1/Primeiros-passos-Instalando-Git) e entre na pasta do projeto

`$ git clone https://github.com/lsfernandes92/fantastic-system`


`$ cd fantastic-system/`

Após rode o bundle para as dependências do projeto

`$ bundle install`

Então crie o banco de dados e rode o servidor

`$ rails db:create`

`$ rails s`

 Após isso acesse o endereço http://localhost:3000 no browser.

### Executando a aplicação pelo Docker

Da mesma maneira abra o terminal, clone a aplicação utilizando o [Git](https://git-scm.com/book/pt-br/v1/Primeiros-passos-Instalando-Git) e entre na pasta

`$ git clone https://github.com/lsfernandes92/fantastic-system`

`$ cd fantastic-system/`

Após isso faça o build do container do docker, que contém a aplicação e seu ambiente de desenvolvimento com o comando:

`$ docker-compose --build`


Inicie o container com

`$ docker-compose up` (para mostrar o log dos processos/servidor no terminal)

ou

`$ docker-compose up -d` (para que dar um "detach" no terminal, assim o mesmo não ficará preso com a execução do container/servidor rails).

Em outro terminal ou no mesmo(caso usou a opção `-d`) faça o seguinte para criar o banco

`docker-compose run web rake db:create`

Nesse momento a aplicação deveria estar rodando no endereço http://localhost:3000 do browser.

## How to run the test suite

Para os testes de unidade e integração foram utilizados RSpec + Capybara como sugerido.

Para executar os mesmo execute o comando

`rspec --format documentation`

Exemplo de saida

```
Create todo list
  marked as public
  marked as private

TodoItem
  should be invalid with long content(more than 40 characters)
  should be valid
  should be invalid without content
  Associations
    should belongs to a todo list

Show public lists
  from other users
...
Finished in 1.9 seconds (files took 2.61 seconds to load)
31 examples, 0 failures, 1 pending
```

## Melhorias futuras

  - [] Implementar modelos de "todo_items" e "sub_tasks" a partir de uma classe parent que refencie ele mesmo para os childs(Lista de subtarefas deve ser infinita do nível 3)
  - [] Melhoria nas views com presenters ou framework semelhante, como forma de ajudar as views a renderizar pequenas lógicas

## Toubleshootings

### Problema com pids da pasta /tmp do projeto

Por razões que não conheço as vezes so servidor pede para deletar um arquivo dentro da pasta `app/tmp/pids`, caso contrário ele não inicia.

Para isso basta deletar o mesmo e reiniciar o servidor com "Ctrl+D" e `$ rails c` ou `$ docker-compose down` e `docker-compose up -d` com o Docker.


### Permissão negada para rodar os arquivos de teste

Utilizando o Ubuntu com o Docker para buildar e executar a aplicação, em algumas ocasiões após tentar rodar os testes com `rspec --format documentation`, os testes retorna com um erro de "Permission denied".

Para isso rode o comando dentro da pasta aplicação no terminal.

`$ sudo chown -R $USER:$USER .`

Isso acontece porque o container utiliza o usuário "root" para rodar algumas comandos no Linux.
