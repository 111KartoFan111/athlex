import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio);
});

class UserRepository {
  final Dio _dio;

  UserRepository(this._dio);

  Future<void> setupProfile({
    required int primarySportId,
    required String level,
    required String goal,
  }) async {
    try {
      await _dio.post('/users/profile', data: {
        'primarySportId': primarySportId,
        'level': level.toUpperCase(), // Match backend enum format
        'goal': goal,
      });
    } catch (e) {
      throw Exception('Failed to setup profile: $e');
    }
  }

  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await _dio.get('/users/dashboard');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch dashboard stats: $e');
    }
  }
}
