import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  late int? id;
  late String name;
  late String email;
  late String? password;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.password,
  });

  UserModel.padrao();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
