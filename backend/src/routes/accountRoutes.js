import express from "express";
import * as accountController from "../controllers/accountController.js";
import { authMiddleware } from "../middleware/middleware.js";

const router = express.Router();

router.post("/", authMiddleware, accountController.handleCreateAccount);
router.get("/:id", authMiddleware, accountController.handleGetAccountById);
router.delete("/:id", authMiddleware, accountController.handleDeleteAccount);

export default router;