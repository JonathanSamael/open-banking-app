import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_banking_app/providers/api_provider.dart';
import 'package:open_banking_app/providers/login_provider.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  final login = ref.watch(loginProvider);

  final token = login.value?.token;

  return UserRepository(client, token);
});

class UsersNotifier extends AsyncNotifier<UserModel?> {
  late final UserRepository _repository;

  @override
  FutureOr<UserModel?> build() async {
    _repository = ref.watch(userRepositoryProvider);
    return null;
  }

  Future<UserModel?> getUserById({
    String? token,
    required String id,
  }) async {
    state = const AsyncLoading();
    try {
      final user = await _repository.getUserById(token, id: id);
      state = AsyncData(user);
      return user;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  Future<void> addUser(Map<String, dynamic> body) async {
    try {
      final newUser = await _repository.createUser(body: body);
      state = AsyncData(newUser);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteUser(String token, String id) async {
    try {
      await _repository.deleteUser(token, id: id);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void clear() {
    state = const AsyncData(null);
  }
}

final userProvider = AsyncNotifierProvider<UsersNotifier, UserModel?>(
  UsersNotifier.new,
);
