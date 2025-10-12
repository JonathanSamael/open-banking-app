import * as accountService from "../services/accountService.js";

//POST /accunts
export const handlecreateAccount = async (req, res) => {
  try {
    const { userId, type } = req.body;

    const validTypes = ["corrente", "poupança"];
    if (!validTypes.includes(type)) {
      return res.status(400).json({
        message: `Erro ao criar conta: tipo inválido. Tipos aceitos: ${validTypes.join(
          ", "
        )}.`,
      });
    }
    const account = await accountService.createAccount(userId, type);
    res.status(201).json(account);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

//GET /accounts/:id
export const handleGetAccountById = async (req, res) => {
  try {
    const { id } = req.params;
    const account = await accountService.getAccountById(id);
    res.json(account);
  } catch (error) {
    res.status(404).json({ message: error.message });
  }
};

// DELETE /account/:id
export const handleDeleteAccount = async (req, res) => {
  try {
    const accountId = req.params;
    const deleted = await accountService.deleteAccount(accountId);

    if (!deleted) {
      return res
        .status(404)
        .json({ message: `Erro ao deletar conta, conta não encontrada` });
    }

    res.status(200).json({ message: "Conta deletada com sucesso!" });
  } catch (error) {
    const status = error.status || 500;
    res
      .status(status)
      .json({ message: `Erro ao deletar conta, ${status} ${error.message}` });
  }
};
