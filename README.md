# Estoque Fácil

Aplicativo mobile para controle de produtos e estoque, desenvolvido em Flutter e Dart como projeto acadêmico do curso de Análise e Desenvolvimento de Sistemas.

## Objetivo

O Estoque Fácil permite que usuários realizem o controle de seus produtos, consultem informações do estoque e gerenciem seus cadastros. O projeto foi desenvolvido de forma incremental, recebendo novas funcionalidades a cada trabalho.

## Tecnologias utilizadas

- Flutter e Dart
- Firebase Core
- Firebase Authentication
- Cloud Firestore
- GoRouter
- Material Design
- VS Code
- Android Emulator

## Funcionalidades

### Autenticação de usuários

- Cadastro de usuários com e-mail e senha.
- Login.
- Recuperação de senha por e-mail.
- Logout.
- Proteção das telas internas para usuários não autenticados.

### Controle de produtos

- Cadastro de produtos.
- Listagem dos produtos cadastrados.
- Visualização dos detalhes.
- Edição das informações.
- Exclusão de produtos com confirmação.
- Atualização dos dados em tempo real pelo Cloud Firestore.

### Tratamento de estados

- Indicador de carregamento durante a consulta.
- Mensagem quando não existem produtos cadastrados.
- Tratamento de erros durante a leitura dos dados.

## Estrutura do Firestore

Os produtos são armazenados em coleções individuais para cada usuário, utilizando o UID fornecido pelo Firebase Authentication.

```text
users/
  └── UID_DO_USUARIO/
      └── products/
          ├── ID_DO_PRODUTO_1
          └── ID_DO_PRODUTO_2
```

Cada produto possui os seguintes campos:

- `nome`: nome do produto.
- `categoria`: categoria do produto.
- `preco`: preço.
- `quantidade`: quantidade disponível.
- `createdAt`: data de criação.
- `updatedAt`: data da última atualização.

## Regras de segurança

O Cloud Firestore utiliza regras para permitir a leitura e a escrita somente quando o usuário está autenticado e o UID da autenticação corresponde ao identificador da coleção.

```javascript
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {

    match /users/{userId}/products/{productId} {
      allow read, write: if request.auth != null
                         && request.auth.uid == userId;
    }

  }
}
```

Dessa forma, cada usuário acessa somente os próprios produtos.

## Testes realizados

Foram realizados testes utilizando o aplicativo no emulador Android.

| Teste | Resultado |
|---|---|
| Cadastro de produto | Aprovado |
| Listagem de produtos | Aprovado |
| Edição de produto | Aprovado |
| Exclusão de produto | Aprovado |
| Persistência após reabrir o aplicativo | Aprovado |
| Isolamento entre duas contas | Aprovado |

No teste de isolamento, uma segunda conta foi utilizada para verificar que os produtos cadastrados pela primeira conta não ficavam visíveis para ela.

## Organização do projeto

A aplicação está organizada em pastas separadas por responsabilidade:

- `lib/domain/`: modelos e entidades do projeto.
- `lib/data/repositories/`: comunicação com Firebase Authentication e Cloud Firestore.
- `lib/ui/auth/`: telas de autenticação.
- `lib/ui/home/`: tela inicial.
- `lib/ui/produto/`: lista, cadastro, detalhes e edição dos produtos.
- `lib/app/`: configuração de rotas e navegação.
- `lib/main.dart`: inicialização da aplicação.

## Como executar o projeto

É necessário ter o Flutter instalado e configurado, além de um emulador Android ou dispositivo compatível.

1. Clone o repositório:

```bash
git clone https://github.com/Leotec29/estoque_facil.git
```

2. Entre na pasta do projeto:

```bash
cd estoque_facil
```

3. Instale as dependências:

```bash
flutter pub get
```

4. Execute o aplicativo:

```bash
flutter run
```

A configuração do Firebase também deve estar disponível para o aplicativo funcionar corretamente.

## Repositório

GitHub: https://github.com/Leotec29/estoque_facil

## Conclusão

O Estoque Fácil evoluiu de uma aplicação com dados locais para um aplicativo com autenticação de usuários e armazenamento em nuvem. Com a integração do Cloud Firestore, passou a oferecer operações completas de cadastro, consulta, edição e exclusão de produtos, além de garantir o isolamento dos dados de cada usuário.