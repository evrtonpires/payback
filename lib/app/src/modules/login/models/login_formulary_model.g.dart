// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_formulary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginFormularyModel _$LoginFormularyModelFromJson(Map<String, dynamic> json) =>
    LoginFormularyModel(
      login: json['login'] as String,
      password: json['password'] as String,
      cnpj: json['cnpj'] as String,
    );

Map<String, dynamic> _$LoginFormularyModelToJson(
        LoginFormularyModel instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
      'cnpj': instance.cnpj,
    };
