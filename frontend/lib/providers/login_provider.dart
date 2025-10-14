import 'dart:async';
import 'dart:convert';
import 'package:open_banking_app/core/api_client.dart';
import 'package:open_banking_app/providers/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/login_model.dart';

class LoginNotifier extends AsyncNotifier<LoginModel?> {
  late final ApiClient _client;

  @override
  FutureOr<LoginModel?> build() async {
    _client = ref.watch(apiClientProvider);
    return null;
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    try {
      final response = await _client.post(
        '/login',
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final loginData = LoginModel.fromJson(jsonData);

        state = AsyncData(loginData);
      } else {
        throw Exception('Erro ao fazer login: ${response.statusCode} ${response.body}');
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  logout() {
    state = const AsyncData(null);
  }

  String? get token => state.value?.token;
}

final loginProvider = AsyncNotifierProvider<LoginNotifier, LoginModel?>(
  LoginNotifier.new,
);
