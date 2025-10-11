import { getAllUsers, addUser } from "../services/userService.js";

export const getUsers = async (req, res) => {
  try {
    const users = await getAllUsers();
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: `Erro ao buscar usuários, ${error}` });
  }
};

export const createUser = async (req, res) => {
  try {
    const newUser = await addUser(req.body);
    res.status(201).json(newUser);
  } catch (error) {
    res.status(500).json({ error: `Erro ao criar usuários, ${error}` });
  }
};
