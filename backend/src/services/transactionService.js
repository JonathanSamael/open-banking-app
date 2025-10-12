import db from "../database/db.js";
import { nanoid } from "nanoid";
import { deleteFromDb } from "./utils/deleteFromDb.js";

export const getAllTransactions = async () => {
  await db.read();
  return db.data.transactions || [];
};

export const getTransactionsByAccount = async (accountId) => {
  await db.read();
  return db.data.transactions.filter(
    (transaction) => transaction.accountId === accountId
  );
};

export const createTransaction = async (data) => {
  const { accountId, type, amount, description, toAccountId } = data;
  await db.read();

  const accounts = db.data.accounts;
  const sourceAccount = accounts.find((account) => account.id === accountId);

  if (!sourceAccount) throw new Error("Conta origem não encontrada");
  if (amount <= 0) throw new Error("Valor inválido");

  switch (type) {
    case "deposit":
      sourceAccount.balance += amount;
      break;

    case "withdraw":
      if (sourceAccount.balance < amount) throw new Error("Saldo insuficiente");
      sourceAccount.balance -= amount;
      break;

    case "transfer":
      if (sourceAccount.balance < amount) throw new Error("Saldo insuficiente");

      const targetAccount = accounts.find((a) => a.id === toAccountId);
      if (!targetAccount) throw new Error("Conta destino não encontrada");

      sourceAccount.balance -= amount;
      targetAccount.balance += amount;
      break;

    default:
      throw new Error("Tipo de transação inválido");
  }

  const transaction = {
    id: nanoid(),
    accountId,
    type,
    amount,
    description: description || "",
    toAccountId: toAccountId || null,
    date: new Date().toISOString(),
  };

  db.data.transactions.push(transaction);
  await db.write();

  return transaction;
};

export const deleteTransaction = async (id) => {
  const deleted = await deleteFromDb("transactions", id);
  return deleted;
};
