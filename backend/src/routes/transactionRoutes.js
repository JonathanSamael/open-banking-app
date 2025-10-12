import express from "express";
import * as transactionController from "../controllers/transactionController.js";
import { authMiddleware } from "../middleware/middleware.js";

const router = express.Router();

router.get("/", authMiddleware, transactionController.handleGetAllTransactions);
router.get("/:accountId", authMiddleware, transactionController.handleGetTransactionsByAccount);
router.post("/", authMiddleware, transactionController.handleCreateTransaction);
router.delete("/:id", authMiddleware, transactionController.handleDeleteTransaction);

export default router;
