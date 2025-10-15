import 'dart:convert';
import '../core/api_client.dart';
import '../models/account_model.dart';

class AccountRepository {
  final ApiClient client;
  final String? token;

  AccountRepository(this.client, this.token);

  Future<AccountModel> createAccount({
    String? token,
    required Map<String, dynamic> body,
  }) async {
    final response = await client.post(
      '/accounts',
      body: body,
      authToken: token,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return AccountModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao criar conta. Status: ${response.statusCode}');
    }
  }

  Future<AccountModel> getAccountById({required String id}) async {
    try {
      final response = await client.get('/accounts/$id', authToken: token);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return AccountModel.fromJson(jsonData);
      } else {
        throw Exception(
          'Erro ao buscar conta $id. Status: ${response.statusCode}',
        );
      }
    } on Exception catch (e) {
      throw Exception('Falha na requisição getAccountById: $e');
    }
  }

  Future<void> deleteAccount({
    required String id,
  }) async {
    final response = await client.delete('/accounts/$id', authToken: token);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
        'Erro ao deletar conta $id. Status: ${response.statusCode}',
      );
    }
  }
}
