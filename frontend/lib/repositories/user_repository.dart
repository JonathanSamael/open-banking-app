import 'dart:convert';
import '../core/api_client.dart';
import '../models/user_model.dart';

class UserRepository {
  final ApiClient client;
  final String? token;

  UserRepository(this.client, this.token);

  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await client.get(
        '/users',
        authToken: token,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        final usersList = (jsonData['users'] as List)
            .map((json) => UserModel.fromJson(json))
            .toList();

        return usersList;
      } else {
        throw Exception(
          'Erro ao buscar usuários. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Falha na requisição getAllUsers: $e');
    }
  }

  Future<UserModel> getUserById({required String id}) async {
    try {
      final response = await client.get(
        '/users/$id',
        authToken: token,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return UserModel.fromJson(jsonData);
      } else {
        throw Exception(
          'Erro ao buscar usuário $id. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Falha na requisição getUserById: $e');
    }
  }

  Future<UserModel> createUser({required Map<String, dynamic> body}) async {
    try {
      final response = await client.post(
        '/users',
        body: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return UserModel.fromJson(jsonData);
      } else {
        throw Exception(
          'Erro ao criar usuário. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Falha na requisição createUser: $e');
    }
  }

  Future<UserModel> updateUser({
    required String id,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await client.put(
        '/users/$id',
        body: body,
        authToken: token,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return UserModel.fromJson(jsonData);
      } else {
        throw Exception(
          'Erro ao atualizar usuário $id. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Falha na requisição updateUser: $e');
    }
  }

  Future<void> deleteUser({required String id}) async {
    try {
      final response = await client.delete(
        '/users/$id',
        authToken: token,
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(
          'Erro ao deletar usuário $id. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Falha na requisição deleteUser: $e');
    }
  }
}
