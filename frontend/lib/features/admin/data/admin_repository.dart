import 'package:dio/dio.dart';
import '../../auth/domain/models/user_model.dart';
import '../../sports/domain/models/sport_model.dart';

class AdminRepository {
  final Dio _dio;

  AdminRepository(this._dio);

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _dio.get('/admin/users');
      final List<dynamic> data = response.data;
      return data
          .map((item) => _mapUser(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch admin users: $e');
    }
  }

  UserModel _mapUser(Map<String, dynamic> json) {
    SportModel? sport;
    final rawSport = json['primarySport'];
    if (rawSport is Map<String, dynamic>) {
      final hasCoreFields =
          rawSport['id'] != null &&
          rawSport['name'] != null &&
          rawSport['category'] != null;
      if (hasCoreFields) {
        sport = SportModel.fromJson(rawSport);
      }
    }

    final blocked = (json['isBlocked'] ?? json['blocked']) == true;

    return UserModel(
      id: (json['id'] as num).toInt(),
      email: (json['email'] ?? '') as String,
      role: (json['role'] ?? 'USER').toString(),
      level: json['level']?.toString(),
      primarySport: sport,
      goal: json['goal']?.toString(),
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      rankTitle: json['rankTitle']?.toString(),
      isBlocked: blocked,
    );
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
      await _dio.put(
        '/admin/users/$userId/role',
        queryParameters: {'role': role},
      );
    } catch (e) {
      throw Exception('Failed to update user role: $e');
    }
  }
}
