import db from "../database/db.js";
import { deleteFromDb } from "./utils/deleteFromDb.js";
import { nanoid } from "nanoid";

export const createAccount = async (userId, type) => {
  const existingAccount = db.data.accounts.find((acc) => acc.userId === userId);

  if (existingAccount) {
    return {
      alreadyExists: true,
      account: existingAccount,
    };
  }

  const newAccount = {
    id: nanoid(),
    userId,
    type,
    balance: 0,
    createdAt: new Date().toISOString(),
  };

  db.data.accounts.push(newAccount);
  await db.write();

  return {
    alreadyExists: false,
    account: newAccount,
  };
};

export const getAccountById = async (userId) => {
  const userAccounts = db.data.accounts.find((acc) => acc.userId === userId);

  if (!userAccounts || userAccounts.length === 0) {
    throw new Error("Nenhuma conta encontrada para este usuário.");
  }

  return userAccounts;
};

export const deleteAccount = (id) => deleteFromDb("accounts", id);
