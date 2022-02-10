// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescribe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescribeModel _$PrescribeModelFromJson(Map<String, dynamic> json) =>
    PrescribeModel(
      id: json['id'] as int,
      code: json['code'] as String,
      imgUrl: json['imgUrl'] as String?,
      created_at: json['created_at'] as String,
      drugs: (json['drugs'] as List<dynamic>)
          .map((e) => DrugModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      companyId: json['companyId'] as int,
    );

Map<String, dynamic> _$PrescribeModelToJson(PrescribeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'imgUrl': instance.imgUrl,
      'created_at': instance.created_at,
      'drugs': instance.drugs,
      'companyId': instance.companyId,
    };
