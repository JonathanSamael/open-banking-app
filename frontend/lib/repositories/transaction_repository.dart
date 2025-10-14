import 'dart:convert';

import '../core/api_client.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final ApiClient client;
  final String? token;

  TransactionRepository(this.client, this.token);

  Future<List<TransactionModel>> getAllTransactions() async {
    final response = await client.get('/transactions', authToken: token);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['transactions'];
      return data.map((json) => TransactionModel.fromJson(json)).toList();
    } else {
      throw Exception(
        'Erro ao buscar transações. Status: ${response.statusCode}',
      );
    }
  }

  Future<List<TransactionModel>> getTransactionByAccount({
    required String accountId,
  }) async {
    final response = await client.get(
      '/transactions',
      queryParameters: {'accountId': accountId},
      authToken: token,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['transactions'];
      return data.map((json) => TransactionModel.fromJson(json)).toList();
    } else {
      throw Exception(
        'Erro ao buscar transações da conta $accountId. Status: ${response.statusCode}',
      );
    }
  }

  Future<TransactionModel> createTransaction({
    required Map<String, dynamic> body,
  }) async {
    final response = await client.post(
      '/transactions',
      body: body,
      authToken: token,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TransactionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Erro ao criar transação. Status: ${response.statusCode}',
      );
    }
  }

  Future<void> deleteTransaction({
    required String token,
    required String id,
  }) async {
    final response = await client.delete('/transactions/$id', authToken: token);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
        'Erro ao deletar transação $id. Status: ${response.statusCode}',
      );
    }
  }
}
