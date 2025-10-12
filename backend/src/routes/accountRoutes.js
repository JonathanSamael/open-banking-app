import express from "express";
import { handlecreateAccount, handleGetAccountById, handleDeleteAccount } from "../controllers/accountController.js";
import { authMiddleware } from "../middleware/middleware.js";

const router = express.Router();

router.post("/", authMiddleware, handlecreateAccount);
router.get("/:id", authMiddleware, handleGetAccountById);
router.delete("/:id", authMiddleware, handleDeleteAccount);

export default router;