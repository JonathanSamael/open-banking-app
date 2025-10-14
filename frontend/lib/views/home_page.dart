import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_banking_app/providers/account_provider.dart';
import 'package:open_banking_app/providers/login_provider.dart';
import 'package:open_banking_app/providers/user_provider.dart';
import 'package:open_banking_app/views/login_page.dart';
import 'package:open_banking_app/views/widgets/account_card.dart';
import 'package:open_banking_app/views/widgets/action_buttons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final account = ref.watch(accountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${user.value!.name}'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              ref.read(loginProvider.notifier).logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AccountCard(account: account.value!),
            const SizedBox(height: 20),
            ActionButtons(accountId: account.value!.id),
          ],
        ),
      ),
    );
  }
}
