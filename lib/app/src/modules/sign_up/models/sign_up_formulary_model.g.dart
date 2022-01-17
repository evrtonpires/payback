// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_formulary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpFormularyModel _$SignUpFormularyModelFromJson(
        Map<String, dynamic> json) =>
    SignUpFormularyModel(
      name: json['name'] as String,
      email: json['email'] as String?,
      password: json['password'] as String,
      cnpj: json['cnpj'] as String,
      type: json['type'] as int,
    );

Map<String, dynamic> _$SignUpFormularyModelToJson(
        SignUpFormularyModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'type': instance.type,
    };
