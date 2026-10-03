# 📦 Estoque Fácil

Aplicativo mobile desenvolvido em Flutter para auxiliar no controle simples de produtos e estoque.

## 📌 Sobre o projeto

O **Estoque Fácil** é um aplicativo desenvolvido como projeto acadêmico do curso de Análise e Desenvolvimento de Sistemas (ADS).

A proposta é criar uma solução simples para facilitar o cadastro, visualização e organização de produtos de um estoque.

Nesta etapa do projeto, o aplicativo foi evoluído com **autenticação de usuários utilizando Firebase Authentication**, mantendo as funcionalidades de produtos da versão anterior.

## 🎯 Objetivo

O objetivo do aplicativo é oferecer uma interface simples para que o usuário possa:

* Criar uma conta;
* Entrar no aplicativo;
* Recuperar a senha;
* Sair da conta;
* Visualizar produtos cadastrados;
* Consultar informações de um produto;
* Cadastrar novos produtos;
* Informar preço e quantidade em estoque;
* Receber mensagens de validação e confirmação.

## 🔐 Autenticação

Nesta etapa foi implementada a autenticação utilizando **Firebase Authentication**.

O aplicativo possui:

* Cadastro de usuários com e-mail e senha;
* Login com e-mail e senha;
* Recuperação de senha por e-mail;
* Logout;
* Validação dos campos dos formulários;
* Mensagens de erro para situações de autenticação;
* Proteção das telas internas;
* Redirecionamento para o login quando o usuário não está autenticado;
* Manutenção da sessão do usuário através do Firebase.

As informações de senha não são armazenadas manualmente pelo aplicativo. O gerenciamento da autenticação é realizado pelo Firebase Authentication.

## 🏠 Tela inicial

Após realizar o login, o usuário tem acesso à tela inicial do Estoque Fácil.

A tela apresenta:

* Quantidade de produtos cadastrados;
* Quantidade total de itens em estoque;
* Acesso à lista de produtos;
* Acesso ao cadastro de produtos;
* Opção para sair da conta.

## 📦 Lista de produtos

Exibe os produtos cadastrados utilizando dados simulados.

Atualmente são utilizados três produtos de exemplo:

* Martelo;
* Furadeira;
* Chave de Fenda.

## 📄 Detalhes do produto

Permite visualizar as informações individuais de cada produto selecionado.

São exibidos:

* Nome;
* Categoria;
* Preço;
* Quantidade em estoque;
* ID.

## ➕ Cadastro de produto

Possui um formulário para cadastro de novos produtos com os campos:

* Nome;
* Categoria;
* Preço;
* Quantidade em estoque.

O formulário possui validações para evitar informações vazias ou inválidas.

Após o preenchimento correto, o aplicativo apresenta uma mensagem de confirmação.

> **Observação:** nesta etapa, os produtos ainda utilizam dados mockados e não possuem persistência no banco de dados. A utilização do Cloud Firestore e o CRUD dos produtos serão implementados em uma etapa posterior.

## 🛠️ Tecnologias utilizadas

* **Flutter**
* **Dart**
* **Material Design**
* **GoRouter**
* **Firebase Core**
* **Firebase Authentication**
* **VS Code**
* **Android Studio**
* **Android Emulator**

## 📂 Estrutura do projeto

```text
lib
├── app
│   ├── auth_router_refresh.dart
│   └── router.dart
│
├── data
│   ├── produto_mock.dart
│   └── repositories
│       └── auth_repository.dart
│
├── domain
│   └── produto.dart
│
├── ui
│   ├── auth
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── forgot_password_screen.dart
│   │
│   ├── home
│   │   └── home_screen.dart
│   │
│   └── produto
│       ├── produto_detail_screen.dart
│       ├── produto_form_screen.dart
│       └── produto_list_screen.dart
│
├── firebase_options.dart
└── main.dart
```

A organização separa as responsabilidades do projeto:

* `app`: configuração da navegação e atualização das rotas conforme o estado de autenticação;
* `data`: dados simulados e acesso aos serviços de autenticação;
* `domain`: entidades e modelos;
* `ui/auth`: telas de login, cadastro e recuperação de senha;
* `ui/home`: tela principal do aplicativo;
* `ui/produto`: telas relacionadas aos produtos;
* `firebase_options.dart`: configurações geradas para integração com o Firebase;
* `main.dart`: inicialização do aplicativo e do Firebase.

## ▶️ Como executar o projeto

### Pré-requisitos

É necessário ter instalado:

* Flutt*
