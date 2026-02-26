import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../domain/models/sport_model.dart';

final sportRepositoryProvider = Provider<SportRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return SportRepository(dio);
});

class SportRepository {
  final Dio _dio;

  SportRepository(this._dio);

  Future<List<SportModel>> getSports() async {
    try {
      final response = await _dio.get('/sports');
      final List<dynamic> data = response.data;
      return data.map((json) => SportModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch sports: $e');
    }
  }
}
