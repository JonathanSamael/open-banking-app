import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_banking_app/providers/login_provider.dart';
import '../models/account_model.dart';
import '../repositories/account_repository.dart';
import 'api_provider.dart';

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) {
  final client = ref.watch(apiClientProvider);
  final login = ref.watch(loginProvider);

  final token = login.value?.token; // <- token em memória

  return AccountRepository(client, token);
}
);

class AccountNotifier extends AsyncNotifier<AccountModel?> {
  late final AccountRepository _repository;

  @override
  FutureOr<AccountModel?> build() async {
    _repository = ref.watch(accountRepositoryProvider);
    return null;
  }

  Future<void> createAccount(String token, Map<String, dynamic> body) async {
    state = const AsyncLoading();
    try {
      final account = await _repository.createAccount( body: body);
      state = AsyncData(account);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> getAccountById(String token, String id) async {
    state = const AsyncLoading();
    try {
      final account = await _repository.getAccountById(token: token, id: id);
      state = AsyncData(account);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteAccount(String token, String id) async {
    try {
      await _repository.deleteAccount(token: token, id: id);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final accountProvider = AsyncNotifierProvider<AccountNotifier, AccountModel?>(
  AccountNotifier.new,
);
