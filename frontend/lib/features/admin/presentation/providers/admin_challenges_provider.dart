import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../challenges/domain/models/challenge_model.dart';

class AdminChallengeRepository {
  final _dio;

  AdminChallengeRepository(this._dio);

  Future<List<ChallengeModel>> getChallenges() async {
    final response = await _dio.get('/admin/challenges');
    final data = response.data as List<dynamic>;
    return data
        .map((json) => ChallengeModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> createChallenge(Map<String, dynamic> request) async {
    await _dio.post('/admin/challenges', data: request);
  }

  Future<void> deleteChallenge(int challengeId) async {
    await _dio.delete('/admin/challenges/$challengeId');
  }
}

final adminChallengeRepositoryProvider = Provider<AdminChallengeRepository>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return AdminChallengeRepository(dio);
});

final adminChallengesProvider = FutureProvider<List<ChallengeModel>>((
  ref,
) async {
  final repository = ref.watch(adminChallengeRepositoryProvider);
  return repository.getChallenges();
});

class AdminChallengeActionNotifier extends StateNotifier<AsyncValue<void>> {
  final AdminChallengeRepository _repository;
  final Ref _ref;

  AdminChallengeActionNotifier(this._repository, this._ref)
    : super(const AsyncValue.data(null));

  Future<void> createChallenge(Map<String, dynamic> request) async {
    state = const AsyncValue.loading();
    try {
      await _repository.createChallenge(request);
      _ref.invalidate(adminChallengesProvider);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteChallenge(int challengeId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteChallenge(challengeId);
      _ref.invalidate(adminChallengesProvider);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final adminChallengeActionProvider =
    StateNotifierProvider<AdminChallengeActionNotifier, AsyncValue<void>>((
      ref,
    ) {
      final repo = ref.watch(adminChallengeRepositoryProvider);
      return AdminChallengeActionNotifier(repo, ref);
    });
