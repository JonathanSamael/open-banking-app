import * as transactionService from "../services/transactionService.js";

//GET /transactions
export const handleGetAllTransactions = async (req, res) => {
  try {
    const transactions = await transactionService.getAllTransactions();
    res.status(200).json(transactions);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

//GET /transactions/:id
export const handleGetTransactionsByAccount = async (req, res) => {
  try {
    const { accountId } = req.params;
    const transactions = await transactionService.getTransactionsByAccount(accountId);
    res.status(200).json(transactions);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

//POST /transactions
export const handleCreateTransaction = async (req, res) => {
  try {
    const transaction = await transactionService.createTransaction(req.body);
    res.status(201).json(transaction);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

//DELETE /transactions/:id
export const handleDeleteTransaction = async (req, res) => {
  try {
    const { id } = req.params;
    const deleted = await transactionService.deleteTransaction(id);
    console.log(id)

    if (!deleted) {
      return res.status(404).json({ message: "Transação não encontrada" });
    }

    res.status(200).json({ message: "Transação cancelada com sucesso" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
