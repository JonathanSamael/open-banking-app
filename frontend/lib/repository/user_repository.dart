import '../core/api_client.dart';
import '../models/user_model.dart';

class UserRepository {
  final ApiClient client;

  UserRepository(this.client);

  Future<List<UserModel>> getAllUsers(String token) async {
    final data = await client.get('users', token);
    return (data['users'] as List).map((json) => UserModel.fromJson(json)).toList();
  }
}
