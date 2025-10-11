import { Router } from "express";
import { handleGetAllUsers, handleGetUserById, handleAddUser, handleUpdateUser, handleDeleteUser } from "../controllers/userController.js";
import { authMiddleware } from "../middleware/middleware.js"

const router = Router();

router.post("/", handleAddUser);
router.get("/", authMiddleware, handleGetAllUsers);
router.get("/:id", authMiddleware, handleGetUserById);
router.put("/:id", authMiddleware, handleUpdateUser);
router.delete("/:id", authMiddleware, handleDeleteUser);

export default router;
