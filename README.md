# Open Banking App

Projeto de exemplo de **Open Banking** com backend em Node.js/Express e frontend em Flutter.  
Este repositório contém duas pastas principais: `backend/` e `frontend/`.

---

## Descrição do Projeto

Este projeto tem como objetivo simular operações de **usuários, contas e transações** de um banco digital.  
Ele inclui autenticação JWT, gerenciamento de contas, movimentações financeiras (depósitos, saques, transferências) e organização do backend seguindo uma arquitetura em camadas.

---

## Estrutura do Repositório

```
open_banking_app/
├── backend/       # Backend Node.js/Express + LowDB
├── frontend/      # Aplicativo Flutter
├── .gitignore
└── README.md
```

## Backend

O backend está localizado na pasta `backend/` e possui:

- CRUD de **Usuários**, **Contas** e **Transações**
- Autenticação via JWT
- Banco de dados local com **LowDB** usando a lib json-server
- Estrutura de camadas: Controllers → Services → Utils → DB

#### **Camadas do Projeto - Backend**

```
backend/
   └──src/
        ├── controllers/   → tratam req/res HTTP
        ├── services/      → regras de negócio
        ├── utils/         → funções genéricas
        ├── routes/        → definição de endpoints
        ├── database/      → LowDB config
        ├── middleware/    → autenticação JWT
        └── app.js
```

### Como rodar o backend:

```bash
cd backend
npm install
npm run dev
```

> Para mais detalhes acesse o README.md dentro do projeto backend;

- Documentação do **Backend**:
  **[Clique para ver os detalhes de instalação e uso](backend/README.md)**

---

## Frontend

O frontend está localizado na pasta `frontend/`.

Arquitetura em Camadas com Padrão Repository e Gerenciamento de Estado via Provider.

- Telas de **Login**, **Cadastro** e **Home**
- Gerenciamento de estado com Riverpod
- Estrutura de camadas: Core → Providers → Repositories → views

#### **Camadas do Projeto - Frontend**

```
Frontend/
   lib/
        ├── core/           → client HTTP
        ├── models/         → models para lidar com os dados do backend gerenciados com flutter_riverpod
        ├── providers/      → requisições de chamadas para as views
        ├── repositories/   → métodos de busca e fonte de dados para os providers
        ├── utils/          → arquivos genéricos
        ├── views/          → telas do app
        ├── app.dart
        └── main.dart
        pubspec.yaml
        README.md
```

> Para mais detalhes acesse o README.md dentro do projeto frontend;


- Documentação do **Frontend**:
  **[Clique para ver as instruções do front-end](frontend/README.md)**

---

## Tecnologias utilizadas

- Backend
  - Node.js
  - Express
  - LowDB
  - JWT (Json Web Token)
- Frontend
  - Flutter
    - HttpClient
    - Riverpod

---

## **Autor**

Desenvolvido por **Jonathan Samael** - 2025

> Projeto — Open Banking App
