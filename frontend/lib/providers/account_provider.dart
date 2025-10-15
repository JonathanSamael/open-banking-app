import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_banking_app/providers/login_provider.dart';
import '../models/account_model.dart';
import '../repositories/account_repository.dart';
import 'api_provider.dart';

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  final login = ref.watch(loginProvider);

  final token = login.value?.token;

  return AccountRepository(client, token);
});

class AccountNotifier extends AsyncNotifier<AccountModel?> {
   AccountRepository get _repository => ref.watch(accountRepositoryProvider);

  @override
  FutureOr<AccountModel?> build() async {
    return null;
  }

  Future<void> createAccount(String token, Map<String, dynamic> body) async {
    state = const AsyncLoading();
    try {
      final account = await _repository.createAccount(token: token, body: body);
      state = AsyncData(account);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<AccountModel?> getAccountById({required String id}) async {
    state = const AsyncLoading();
    try {
      final account = await _repository.getAccountById(id: id);
      state = AsyncData(account);
      return account;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
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
