import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_banking_app/providers/login_provider.dart';
import '../models/transaction_model.dart';
import '../repositories/transaction_repository.dart';
import 'api_provider.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  final login = ref.watch(loginProvider);

  final token = login.value?.token;

  return TransactionRepository(client, token);
});

class TransactionsNotifier extends AsyncNotifier<List<TransactionModel>> {
  late final TransactionRepository _repository;

  @override
  FutureOr<List<TransactionModel>> build() async {
    _repository = ref.watch(transactionRepositoryProvider);
    return [];
  }

  Future<void> getAllTransactions() async {
    state = const AsyncLoading();
    try {
      final transactions = await _repository.getAllTransactions();
      state = AsyncData(transactions);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> getTransactionByAccount(String accountId) async {
    state = const AsyncLoading();
    try {
      final transactions = await _repository.getTransactionByAccount(
        accountId: accountId,
      );
      state = AsyncData(transactions);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> createTransaction(
    {required Map<String, dynamic> body}
  ) async {
    try {
      final newTransaction = await _repository.createTransaction(
        body: body,
      );
      state.whenData((list) {
        state = AsyncData([...list, newTransaction]);
      });
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteTransaction(String token, String id) async {
    try {
      await _repository.deleteTransaction(token: token, id: id);
      state.whenData((list) {
        state = AsyncData(list.where((t) => t.id != id).toList());
      });
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final transactionsProvider =
    AsyncNotifierProvider<TransactionsNotifier, List<TransactionModel>>(
      TransactionsNotifier.new,
    );
