import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../auth/domain/models/user_model.dart';
import '../../data/admin_repository.dart';

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AdminRepository(dio);
});

final adminUsersProvider = FutureProvider<List<UserModel>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return repository.getUsers();
});

class AdminUserActionNotifier extends StateNotifier<AsyncValue<void>> {
  final AdminRepository _repository;
  final Ref _ref;

  AdminUserActionNotifier(this._repository, this._ref) : super(const AsyncValue.data(null));

  Future<void> blockUser(int userId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.blockUser(userId);
      _ref.invalidate(adminUsersProvider);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> unblockUser(int userId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.unblockUser(userId);
      _ref.invalidate(adminUsersProvider);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateRole(int userId, String role) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateUserRole(userId, role);
      _ref.invalidate(adminUsersProvider);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final adminUserActionProvider =
    StateNotifierProvider<AdminUserActionNotifier, AsyncValue<void>>((ref) {
  final repo = ref.watch(adminRepositoryProvider);
  return AdminUserActionNotifier(repo, ref);
});
