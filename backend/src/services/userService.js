import db from "../database/db.js";
import { nanoid } from "nanoid";

export const getAllUsers = async () => {
  return db.data.users;
};

export const getUserById = async (id) => {
  return db.data.users.find((user) => user.id === id);
};

export const addUser = async (userData) => {
  const newUser = {
    id: nanoid(),
    ...userData,
  };

  db.data.users.push(newUser);
  await db.write(); 
  return newUser;
};

export const updateUser = async (id, updates) => {
  const index = db.data.users.findIndex((user) => user.id === id);
  if (index === -1) return null;

  db.data.users[index] = { ...db.data.users[index], ...updates };
  await db.write();
  return db.data.users[index];
};

export const deleteUser = async (id) => {
  const initialLength = db.data.users.length;
  db.data.users = db.data.users.filter((user) => user.id !== id);
  if (db.data.users.length === initialLength) return false;

  await db.write();
  return true;
};

