import 'package:freezed_annotation/freezed_annotation.dart';

part 'sport_model.freezed.dart';
part 'sport_model.g.dart';

@freezed
class SportModel with _$SportModel {
  const factory SportModel({
    required int id,
    required String name,
    required String category,
    String? iconUrl,
  }) = _SportModel;

  factory SportModel.fromJson(Map<String, dynamic> json) =>
      _$SportModelFromJson(json);
}
