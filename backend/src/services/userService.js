import bcrypt from "bcryptjs";
import db from "../database/db.js";
import { deleteFromDb } from "./utils/deleteFromDb.js";
import { nanoid } from "nanoid";

export const getAllUsers = async () => {
  return db.data.users;
};

export const getUserById = async (id) => {
  return db.data.users.find((user) => user.id === id);
};

export const addUser = async (userData) => {
  const hashedPassword = await bcrypt.hash(userData.password, 10);

  const newUser = {
    id: nanoid(),
    name: userData.name,
    email: userData.email,
    password: hashedPassword,
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

export const deleteUser = (id) => deleteFromDb("users", id);
