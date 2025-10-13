import '../core/api_client.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final ApiClient client;

  TransactionRepository(this.client);

  Future<List<TransactionModel>> getAllTransactions(String token) async {
    final data = await client.get('transactions', token);
    return (data['transactions'] as List).map((json) => TransactionModel.fromJson(json)).toList();
  }
}