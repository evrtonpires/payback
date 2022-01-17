import 'package:json_annotation/json_annotation.dart';

part 'login_formulary_model.g.dart';

@JsonSerializable()
class LoginFormularyModel {
  late String login;
  late String password;
  late String cnpj;

  LoginFormularyModel({
    required this.login,
    required this.password,
    required this.cnpj,
  });

  LoginFormularyModel.padrao();

  factory LoginFormularyModel.fromJson(Map<String, dynamic> json) =>
      _$LoginFormularyModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginFormularyModelToJson(this);
}
