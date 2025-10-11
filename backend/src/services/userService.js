import db from "../database/db.js";

export const getAllUsers = async () => db.getData("/users");

export const addUser = async (user) => {
  const users = await db.getData("/users");
  const newUser = { id: Date.now(), ...user };
  users.push(newUser);
  await db.push("/users", users);
  return newUser;
};
