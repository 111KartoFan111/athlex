import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../sports/domain/models/sport_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String email,
    required String role,
    String? level,
    SportModel? primarySport,
    String? goal,
    @Default(0) int currentStreak,
    String? rankTitle,
    @Default(false) bool isBlocked,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
