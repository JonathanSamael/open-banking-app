import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import db from "../database/db.js";

export const loginUser = async (email, password) => {
  const JWT_SECRET = process.env.JWT_SECRET;
  
  const user = db.data.users.find((u) => u.email === email);
  if (!user) throw { status: 401, message: "Usuário não encontrado" };

  const passwordMatch = await bcrypt.compare(password, user.password);
  if (!passwordMatch) throw { status: 401, message: "Senha incorreta" };

  const token = jwt.sign({ id: user.id, email: user.email }, JWT_SECRET, {
    expiresIn: "1h",
  });
  return { token, user: { id: user.id, name: user.name, email: user.email } };
};
