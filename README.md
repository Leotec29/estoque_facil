# 📦 Estoque Fácil

Aplicativo mobile desenvolvido em Flutter para auxiliar no controle simples de produtos e estoque.

## 📌 Sobre o projeto

O **Estoque Fácil** é um aplicativo desenvolvido como projeto acadêmico do curso de Análise e Desenvolvimento de Sistemas (ADS).

A proposta é criar uma solução simples para facilitar o cadastro, visualização e organização de produtos de um estoque.

Nesta primeira versão, os dados utilizados são locais e simulados (mock). Nas próximas etapas do projeto, o aplicativo será evoluído para utilizar autenticação de usuários e banco de dados em nuvem.

## 🎯 Objetivo

O objetivo do aplicativo é oferecer uma interface simples para que o usuário possa:

* Visualizar produtos cadastrados;
* Consultar informações de um produto;
* Cadastrar novos produtos;
* Informar preço e quantidade em estoque;
* Receber mensagens de validação e confirmação.

## 🏪 Domínio da aplicação

O projeto pertence ao domínio de **controle de estoque e gerenciamento de produtos**.

O principal objeto utilizado atualmente é o **Produto**, que possui:

* ID;
* Nome;
* Categoria;
* Preço;
* Quantidade em estoque.

## 🚀 Funcionalidades atuais

### 🏠 Tela inicial

Apresenta o aplicativo e um resumo do estoque, mostrando:

* Quantidade de produtos cadastrados;
* Quantidade total de itens em estoque;
* Acesso à lista de produtos;
* Acesso ao cadastro de produtos.

### 📦 Lista de produtos

Exibe os produtos cadastrados utilizando dados simulados.

Atualmente são utilizados três produtos de exemplo:

* Martelo;
* Furadeira;
* Chave de Fenda.

### 📄 Detalhes do produto

Permite visualizar as informações individuais de cada produto selecionado.

São exibidos:

* Nome;
* Categoria;
* Preço;
* Quantidade em estoque;
* ID.

### ➕ Cadastro de produto

Possui um formulário para cadastro de novos produtos com os campos:

* Nome;
* Categoria;
* Preço;
* Quantidade em estoque.

O formulário possui validações para evitar informações vazias ou inválidas.

Após o preenchimento correto, o aplicativo apresenta uma mensagem de confirmação.

> **Observação:** nesta versão acadêmica, o produto cadastrado pelo formulário ainda não é persistido na lista, pois os dados são mockados. A persistência será implementada nas próximas etapas do projeto.

## 🛠️ Tecnologias utilizadas

* **Flutter**
* **Dart**
* **Material Design**
* **GoRouter**
* **VS Code**
* **Android Emulator**

## 📂 Estrutura do projeto

```text
lib
├── app
│   └── router.dart
│
├── data
│   └── produto_mock.dart
│
├── domain
│   └── produto.dart
│
├── ui
│   ├── home
│   │   └── home_screen.dart
│   │
│   └── produto
│       ├── produto_detail_screen.dart
│       ├── produto_form_screen.dart
│       └── produto_list_screen.dart
│
└── main.dart
```

A organização separa as responsabilidades do projeto:

* `app`: configuração da navegação;
* `data`: dados simulados;
* `domain`: entidades e modelos;
* `ui`: telas e interface;
* `main.dart`: inicialização do aplicativo.

## ▶️ Como executar o projeto

### Pré-requisitos

É necessário ter instalado:

* Flutter SDK;
* Dart SDK;
* Android Studio ou outro ambiente compatível;
* Android Emulator ou dispositivo Android;
* VS Code ou outra IDE compatível.

### Executando

Clone o repositório:

```bash
git clone https://github.com/Leotec29/estoque_facil.git
```

Entre na pasta:

```bash
cd estoque_facil
```

Instale as dependências:

```bash
flutter pub get
```

Verifique o projeto:

```bash
flutter analyze
```

Execute o aplicativo:

```bash
flutter run
```

## 📱 Screenshots

As imagens abaixo devem ser adicionadas após a captura das telas do aplicativo.

### Tela inicial

> Adicionar aqui uma captura da Home.

### Lista de produtos

> Adicionar aqui uma captura da lista de produtos.

### Cadastro de produto

> Adicionar aqui uma captura do formulário de cadastro.

## 🔗 Repositório

**GitHub:**
https://github.com/Leotec29/estoque_facil

## 🔮 Evoluções futuras

O projeto será desenvolvido durante as próximas etapas da disciplina.

Entre as futuras evoluções estão:

* Implementação de autenticação com Firebase Authentication;
* Cadastro e login de usuários;
* Associação dos produtos ao usuário autenticado;
* Utilização do Cloud Firestore;
* Persistência dos produtos no banco de dados;
* Operações de criação, leitura, atualização e exclusão (CRUD);
* Melhorias na experiência do usuário;
* Possibilidade de edição e exclusão de produtos.

## ⚠️ Limitações da versão atual

Esta versão possui algumas limitações:

* Os produtos são armazenados apenas em memória através de dados mockados;
* O cadastro ainda não possui persistência;
* Não existe autenticação de usuários;
* Não existe banco de dados em nuvem;
* Os dados são perdidos quando o aplicativo é reiniciado.

Essas limitações fazem parte do escopo da primeira versão e serão tratadas nas próximas etapas do projeto.

## 👨‍💻 Autor

**Leonardo Costa**

Projeto desenvolvido para a disciplina de desenvolvimento de aplicativos utilizando Flutter.
