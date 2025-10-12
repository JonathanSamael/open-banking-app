import { loginUser } from "../services/loginService.js";

//POST /login
export const login = async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ message: "Email e senha são obrigatórios" });
    }

    const result = await loginUser(email, password);
    res.json({ message: "Login realizado com sucesso!",  token: `Bearer ${result.token}`,
      user: result.user});
  } catch (error) {
    const status = error.status || 500;
    res.status(status).json({ message: `Erro no login: ${status} - ${error.message}` });
  }
};
