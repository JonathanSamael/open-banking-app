import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_banking_app/providers/login_provider.dart';
import 'package:open_banking_app/providers/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Área Autenticada'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(loginProvider.notifier).logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          userState.when(
            data: (user) => user == null
                ? const Text('Nenhum usuário logado')
                : Text('Olá, ${user.name}'),
            loading: () => const CircularProgressIndicator(),
            error: (err, _) => Text('Erro: $err'),
          ),
        ],
      ),
    );
  }
}
