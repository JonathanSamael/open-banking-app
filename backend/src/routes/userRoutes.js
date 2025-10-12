import { Router } from "express";
import * as userController from "../controllers/userController.js";
import { authMiddleware } from "../middleware/middleware.js"

const router = Router();

router.post("/", userController.handleAddUser);
router.get("/", authMiddleware, userController.handleGetAllUsers);
router.get("/:id", authMiddleware, userController.handleGetUserById);
router.put("/:id", authMiddleware, userController.handleUpdateUser);
router.delete("/:id", authMiddleware, userController.handleDeleteUser);

export default router;
