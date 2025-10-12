# Open Banking API

API RESTful construída em **Node.js + Express + LowDB**, com autenticação JWT, seguindo arquitetura em camadas (**Controller → Service → Utils → DB**).
O objetivo é simular operações de **usuários, contas e transações** de um ambiente bancário digital.

---

## **Instalação e Execução**

### Clonar o repositório

```bash
git clone https://github.com/JonathanSamael/open-banking-app.git
cd backend
```

### Instalar dependências

```bash
npm install
```

### Rodar o servidor

```bash
npm run dev
```

Servidor padrão:

> http://localhost:3030/api

### Configuração .env

Adicione o arquivo .env na raiz da pasta backend/ com as configurações:
```
PORT=3030
JWT_SECRET= <defina uma jwt-secret>

```
---

## **Autenticação**

A autenticação é feita via **JWT Token**.  
Após logar, adicione o token no header de cada requisição protegida:

```
Authorization: Bearer <seu_token_aqui>
```

---

## **Endpoints**

### Usuários (`/users`)

#### Criar usuário

`POST /users`

```json
{
  "name": "Maria Silva",
  "email": "maria@email.com",
  "password": "123456"
}
```

**Resposta 201**

```json
{
  "id": "aB12cd34Ef",
  "name": "Maria Silva",
  "email": "maria@email.com"
}
```

#### Listar todos os usuários

`GET /users`

#### Deletar usuário

`DELETE /users/:id`

---

### Login (`/login`)

#### Autenticar usuário

`POST /login`

```json
{
  "email": "maria@email.com",
  "password": "123456"
}
```

**Resposta 200**

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR..."
}
```

---

### Contas (`/accounts`)

#### Criar conta

##### As contas podem ser do tipo:

> corrente ou poupança

`POST /accounts`

```json
{
  "userId": "aB12cd34Ef",
  "type": "corrente"
}
```

**Resposta 201**

```json
{
  "id": "1Cp6HxSdf83Jks9L",
  "userId": "aB12cd34Ef",
  "type": "corrente",
  "balance": 0
}
```

#### Listar contas por usuário

`GET /accounts/:userId`

#### Deletar conta

`DELETE /accounts/:id`

---

### Transações (`/transactions`)

#### Criar transação

`POST /transactions`

##### Depósito

```json
{
  "accountId": "1Cp6HxSdf83Jks9L",
  "type": "deposit",
  "amount": 500,
  "description": "Depósito inicial"
}
```

##### Saque

```json
{
  "accountId": "1Cp6HxSdf83Jks9L",
  "type": "withdraw",
  "amount": 200,
  "description": "Saque em caixa eletrônico"
}
```

##### Transferência

```json
{
  "accountId": "1Cp6HxSdf83Jks9L",
  "toAccountId": "2Zp9KsP8HwY4Rt7D",
  "type": "transfer",
  "amount": 150,
  "description": "Transferência para conta poupança"
}
```

**Resposta 201**

```json
{
  "id": "b6f19b6f-f183-4cc7-b77d-8c6cb1b1742a",
  "accountId": "1Cp6HxSdf83Jks9L",
  "type": "deposit",
  "amount": 500,
  "description": "Depósito inicial",
  "toAccountId": null,
  "date": "2025-10-12T22:41:33.731Z"
}
```

#### Listar todas as transações

`GET /transactions`

#### Listar por conta

`GET /transactions/:accountId`

#### Deletar transação

`DELETE /transactions/:id`

---

## **Estrutura do Banco (LowDB) - json-server**

```json
{
  "users": [],
  "accounts": [],
  "transactions": []
}
```

---

## **Camadas do Projeto - Backend**

```
src/
 ├── controllers/   → tratam req/res HTTP
 ├── services/      → regras de negócio
 ├── utils/         → funções genéricas
 ├── routes/        → definição de endpoints
 ├── database/      → LowDB config
 ├── middleware/    → autenticação JWT
 └── app.js
```

---

## **Scripts**

```bash
# Iniciar em modo dev
npm run dev

# Iniciar em modo produção
npm start
```

---

## **Autor**

Desenvolvido por **Jonathan Samael** - 2025

> Projeto — Open Banking App
