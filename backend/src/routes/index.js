import { Router } from "express";
import userRoutes from "./userRoutes.js";
import loginRoutes from "./loginRoutes.js";

const router = Router();

router.use("/users", userRoutes);
router.use("/login", loginRoutes);

export default router;
