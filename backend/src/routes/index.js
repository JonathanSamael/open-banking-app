import { Router } from "express";
import userRoutes from "./userRoutes.js";
import loginRoutes from "./loginRoutes.js";
import accountRoutes from './accountRoutes.js';

const router = Router();

router.use("/users", userRoutes);
router.use("/login", loginRoutes);
router.use("/accounts", accountRoutes);

export default router;
