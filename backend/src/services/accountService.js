import db from "../database/db.js";
import { deleteFromDb } from "./utils/deleteFromDb.js";
import { nanoid } from "nanoid";

export const createAccount = async (userId, type) => {
  const accountId = nanoid();

  const account = {
    id: accountId,
    userId,
    type,
    balance: 0,
    createdAt: new Date().toISOString(),
  };

  db.data.accounts.push(account);
  await db.write();

  return account;
};

export const getAccountById = async (accountId) => {
  return db.data.accounts.find((account) => account.id === accountId);
};

export const deleteAccount = (id) => deleteFromDb("accounts", id);
