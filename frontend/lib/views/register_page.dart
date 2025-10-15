import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_banking_app/providers/account_provider.dart';
import 'package:open_banking_app/providers/login_provider.dart';
import 'package:open_banking_app/utils/app_colors.dart';
import 'package:open_banking_app/utils/decoration_styled.dart';
import 'package:open_banking_app/views/home_page.dart';
import '../../providers/user_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final userBody = {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
    };

    try {
      await ref.read(userProvider.notifier).addUser(userBody);

      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      await ref
          .read(loginProvider.notifier)
          .login(email: email, password: password);

      final login = ref.read(loginProvider.notifier).state;
      final token = login.value?.token;
      final userId = login.value?.user.id;

      if (token == null || userId == null) {
        throw Exception('Falha ao logar usuário recém-criado');
      }

      final accountBody = {"userId": userId, "type": "corrente"};
      await ref
          .read(accountProvider.notifier)
          .createAccount(token, accountBody);

      await ref.read(userProvider.notifier).getUserById(token: token, id: userId);
      await ref.read(accountProvider.notifier).getAccountById(id: userId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Conta criada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao criar conta: $e'),
          backgroundColor: AppColors.errorColor,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Crie sua conta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textColorWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _nameController,
                    decoration: inputDecoration(
                      icon: Icons.person_outline,
                      label: 'Nome',
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe o nome'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: inputDecoration(
                      icon: Icons.email_outlined,
                      label: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe o e-mail'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: inputDecoration(
                      icon: Icons.lock_outline,
                      label: 'Senha',
                    ),
                    obscureText: true,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe a senha'
                        : null,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: Size(120, 50),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      elevation: 0.0,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Cadastrar',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Divider(),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Já tem conta? Faça login",
                      style: TextStyle(
                        color: AppColors.textColorWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
