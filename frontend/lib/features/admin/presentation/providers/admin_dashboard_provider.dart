import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';

class AdminDashboardRepository {
  final _dio;

  AdminDashboardRepository(this._dio);

  Future<Map<String, dynamic>> getDashboardAnalytics() async {
    try {
      final response = await _dio.get('/admin/analytics/dashboard');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch dashboard analytics: $e');
    }
  }
}

final adminDashboardRepositoryProvider = Provider<AdminDashboardRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AdminDashboardRepository(dio);
});

final adminDashboardProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(adminDashboardRepositoryProvider);
  return repository.getDashboardAnalytics();
});
