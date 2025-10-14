import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_banking_app/providers/account_provider.dart';
import 'package:open_banking_app/providers/login_provider.dart';
import 'package:open_banking_app/providers/user_provider.dart';
import 'package:open_banking_app/utils/app_colors.dart';
import 'package:open_banking_app/views/home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    bool isHidden = true;

    void togglePasswordView() {
      setState(() {
        isHidden = !isHidden;
      });
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColorDark,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Open Banking App",
                style: TextStyle(
                  fontSize: 28,
                  color: AppColors.backgroundColorLight,
                ),
              ),
              SizedBox(height: 80),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppColors.inputElements,
                  ),
                  label: Text(
                    "Email",
                    style: TextStyle(color: AppColors.inputElements),
                  ),
                  filled: true,
                  fillColor: AppColors.cardColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.accentColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.accentColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.errorColor,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o e-mail' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.inputElements,
                  ),
                  suffixIcon: InkWell(
                    onTap: togglePasswordView,
                    child: Icon(
                      isHidden ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.inputElements,
                    ),
                  ),
                  label: Text(
                    "Senha",
                    style: TextStyle(color: AppColors.inputElements),
                  ),
                  filled: true,
                  fillColor: AppColors.cardColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.accentColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.accentColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.errorColor,
                      width: 2,
                    ),
                  ),
                ),
                obscureText: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a senha' : null,
              ),
              const SizedBox(height: 32),
              loginState.when(
                loading: () => const CircularProgressIndicator(),
                error: (err, _) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Erro: Tente novamente!"),
                        backgroundColor: AppColors.errorColor,
                        duration: Durations.extralong1,
                      ),
                    );
                  });

                  // Mostra o botão mesmo em caso de erro
                  return _buildLoginButton(context, ref);
                },
                data: (_) => _buildLoginButton(context, ref),
              ),
              SizedBox(height: 40),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Crie sua conta!",
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
    );
  }

  Widget _buildLoginButton(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        minimumSize: Size(120, 50),
        padding: const EdgeInsets.symmetric(vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        elevation: 0.0,
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await ref
              .read(loginProvider.notifier)
              .login(
                email: _emailController.text,
                password: _passwordController.text,
              );

          final loggedUser = ref.read(loginProvider);
          if (loggedUser.value != null) {
            final userId = loggedUser.value!.user.id;
            final token = loggedUser.value!.token;

            final user = await ref
                .read(userProvider.notifier)
                .getUserById(id: userId);
            final account = await ref
                .read(accountProvider.notifier)
                .getAccountById(id: userId);

            print(user);
            print(account);

            final accountData = ref.read(accountProvider);

            print('Usuário carregado: ${accountData} $token');

            if (loggedUser.value != null && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Login bem-sucedido: ${loggedUser.value!.user.email}',
                    style: TextStyle(color: AppColors.textColorBlack),
                  ),
                  backgroundColor: AppColors.successColor,
                ),
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            }
          }
        }
      },
      child: const Text('Entrar'),
    );
  }
}
