import { Router } from "express";
import { handleGetAllUsers, handleGetUserById, handleAddUser, handleUpdateUser, handleDeleteUser } from "../controllers/userController.js";

const router = Router();

router.get("/", handleGetAllUsers);
router.get("/:id", handleGetUserById);
router.post("/", handleAddUser);
router.put("/:id", handleUpdateUser);
router.delete("/:id", handleDeleteUser);

export default router;
