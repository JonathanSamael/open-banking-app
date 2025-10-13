import '../core/api_client.dart';
import '../models/account_model.dart';

class AccountRepository {
  final ApiClient client;

  AccountRepository(this.client);

  Future<List<AccountModel>> getAccountId(String accountId, String token) async {
    final data = await client.get('accounts', token);
    return (data['accounts'] as List).map((json) => AccountModel.fromJson(json)).toList();
  }
}