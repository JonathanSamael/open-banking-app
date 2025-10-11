import {
  getAllUsers,
  getUserById,
  addUser,
  updateUser,
  deleteUser
} from "../services/userService.js";

// GET /users
export const handleGetAllUsers = async (req, res) => {
  try {
    const users = await getAllUsers();
    res.status(200).json(users);
  } catch (error) {
    const status = error.status || 500;
    res.status(status).json({ message: `Erro ao buscar usuários, ${status} ${error.message}` });
  }
};

// GET /users/:id
export const handleGetUserById = async (req, res) => {
  try {
    const { id } = req.params;
    const user = await getUserById(id);

    if (!user) {
      return res.status(404).json({ message: `Erro ao buscar usuário, Usuário não encontrado` });
    }

    res.status(200).json(user);
  } catch (error) {
    const status = error.status || 500;
    res.status(status).json({ message: `Erro ao buscar usuário, ${status} ${error.message}` });
  }
};

// POST /users
export const handleAddUser = async (req, res) => {
  try {
    const userData = req.body;
    if (!userData.name || !userData.email) {
      return res.status(400).json({ message: "Erro ao adicionar usuário, Dados incompletos" });
    }

    const newUser = await addUser(userData);
    res.status(201).json({ message: "Usuário adicionado com sucesso!", newUser });
  } catch (error) {
    const status = error.status || 500;
    res.status(status).json({ message: `Erro ao adicionar usuário, ${status} ${error.message}` });
  }
};

// PUT /users/:id
export const handleUpdateUser = async (req, res) => {
  try {
    const { id } = req.params;
    const updates = req.body;
    const updatedUser = await updateUser(id, updates);

    if (!updatedUser) {
      return res.status(404).json({ message: `Erro ao atualizar usuário, Usuário não encontrado` });
    }

    res.status(200).json({ message: "Usuário atualizado com sucesso!", updatedUser });
  } catch (error) {
    const status = error.status || 500;
    res.status(status).json({ message: `Erro ao atualizar usuário, ${status} ${error.message}` });
  }
};

// DELETE /users/:id
export const handleDeleteUser = async (req, res) => {
  try {
    const { id } = req.params;
    const deleted = await deleteUser(id);

    if (!deleted) {
      return res.status(404).json({ message: `Erro ao deletar usuário, Usuário não encontrado` });
    }

    res.status(200).json({ message: "Usuário deletado com sucesso!" });
  } catch (error) {
    const status = error.status || 500;
    res.status(status).json({ message: `Erro ao deletar usuário, ${status} ${error.message}` });
  }
};
