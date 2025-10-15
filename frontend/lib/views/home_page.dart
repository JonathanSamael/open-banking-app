import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_banking_app/providers/account_provider.dart';
import 'package:open_banking_app/providers/login_provider.dart';
import 'package:open_banking_app/providers/user_provider.dart';
import 'package:open_banking_app/utils/app_colors.dart';
import 'package:open_banking_app/utils/decoration_styled.dart';
import 'package:open_banking_app/views/login_page.dart';
import 'package:open_banking_app/views/widgets/account_card.dart';
import 'package:open_banking_app/views/widgets/action_buttons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final accountAsync = ref.watch(accountProvider);

    Future<void> confirmAndDeleteAccount(
      BuildContext context,
      WidgetRef ref,
    ) async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: const Text('Deseja realmente deletar sua conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              style: buttonStyled(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: buttonStyled(context, background: AppColors.primaryColor),
              child: const Text(
                'Excluir',
                style: TextStyle(color: AppColors.accentColor),
              ),
            ),
          ],
        ),
      );

      if (confirmed != true) return;
      try {
        final accountId = ref.read(accountProvider).value?.id;
        final userId = ref.read(userProvider).value?.id;
        final token = ref.read(loginProvider).value?.token;
        if (accountId == null) throw Exception('Conta não encontrada');
        if (userId == null) throw Exception('Conta não encontrada');

        final account = ref.read(accountProvider.notifier);
        final user = ref.read(userProvider.notifier);

        await user.deleteUser(token!, userId);
        await account.deleteAccount(accountId);

        user.clear();
        account.clear();
        ref.read(loginProvider.notifier).logout();

        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Conta deletada com sucesso')),
        );

        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao deletar conta: $e')));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${user.value?.name ?? ""}'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          accountAsync.when(
            data: (account) {
              if (account == null) {
                return const Center(child: Text('Nenhuma conta encontrada'));
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    AccountCard(account: account),
                    const SizedBox(height: 20),
                    ActionButtons(accountId: account.id),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Erro: $e $st')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextButton(
              onPressed: () {
                confirmAndDeleteAccount(context, ref);
              },
              child: Text(
                'Excluir conta',
                style: TextStyle(color: AppColors.errorColor, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
