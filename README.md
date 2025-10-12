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

---

## Frontend

O frontend está localizado na pasta `frontend/`.

---

- Documentação do **Backend**:
  **[Clique para ver os detalhes de instalação e uso](backend/README.md)**

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
