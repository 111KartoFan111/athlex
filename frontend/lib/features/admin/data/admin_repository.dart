import 'package:dio/dio.dart';
import '../../auth/domain/models/user_model.dart';

class AdminRepository {
  final Dio _dio;

  AdminRepository(this._dio);

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _dio.get('/admin/users');
      final List<dynamic> data = response.data;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch admin users: $e');
    }
  }

  Future<void> blockUser(int userId) async {
    try {
      await _dio.put('/admin/users/$userId/block');
    } catch (e) {
      throw Exception('Failed to block user: $e');
    }
  }

  Future<void> unblockUser(int userId) async {
    try {
      await _dio.put('/admin/users/$userId/unblock');
    } catch (e) {
      throw Exception('Failed to unblock user: $e');
    }
  }

  Future<void> updateUserRole(int userId, String role) async {
    try {
      await _dio.put('/admin/users/$userId/role', queryParameters: {'role': role});
    } catch (e) {
      throw Exception('Failed to update user role: $e');
    }
  }
}
