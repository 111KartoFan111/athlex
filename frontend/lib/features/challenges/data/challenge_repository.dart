import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../domain/models/challenge_model.dart';

final challengeRepositoryProvider = Provider<ChallengeRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ChallengeRepository(dio);
});

class ChallengeRepository {
  final Dio _dio;

  ChallengeRepository(this._dio);

  Future<List<ChallengeModel>> getChallenges() async {
    final response = await _dio.get('/challenges');
    final data = response.data as List<dynamic>;
    return data
        .map((item) => ChallengeModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<ChallengeModel?> getDailyChallenge() async {
    final response = await _dio.get('/challenges/daily');
    if (response.statusCode == 204 ||
        response.data == null ||
        response.data == '') {
      return null;
    }
    return ChallengeModel.fromJson(response.data as Map<String, dynamic>);
  }
}
