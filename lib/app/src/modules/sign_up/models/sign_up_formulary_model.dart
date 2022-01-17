import 'package:json_annotation/json_annotation.dart';

part 'sign_up_formulary_model.g.dart';

@JsonSerializable()
class SignUpFormularyModel {
  late String name;
  late String? email;
  late String password;
  late String cnpj;
  late int type;

  SignUpFormularyModel({
    required this.name,
    required this.email,
    required this.password,
    required this.cnpj,
    required this.type,
  });

  factory SignUpFormularyModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpFormularyModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpFormularyModelToJson(this);
}
