import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_banking_app/providers/account_provider.dart';
import 'package:open_banking_app/providers/login_provider.dart';
import 'package:open_banking_app/providers/user_provider.dart';
import 'package:open_banking_app/utils/app_colors.dart';
import 'package:open_banking_app/utils/decoration_styled.dart';
import 'package:open_banking_app/views/home_page.dart';
import 'package:open_banking_app/views/register_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isHidden = true;

  void togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColorDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                      icon: Icons.lock_outline_rounded,
                      label: 'Senha',
                      suffixIcon: InkWell(
                        onTap: togglePasswordView,
                        child: Icon(
                          isHidden ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.inputElements,
                        ),
                      ),
                    ),
                    obscureText: isHidden,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe a senha'
                        : null,
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

                      return _buildLoginButton(context, ref);
                    },
                    data: (_) => _buildLoginButton(context, ref),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Divider(),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Crie sua conta",
                      style: TextStyle(
                        color: AppColors.textColorWhite,
                        fontSize: 18,
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
            final token = loggedUser.value?.token;

            await ref
                .read(userProvider.notifier)
                .getUserById(token: token, id: userId);
            await ref.read(accountProvider.notifier).getAccountById(id: userId);

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
