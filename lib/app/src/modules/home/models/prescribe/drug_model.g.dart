// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrugModel _$DrugModelFromJson(Map<String, dynamic> json) => DrugModel(
      id: json['id'] as int,
      name: json['name'] as String,
      activePrinciple: json['activePrinciple'] as String,
      logoUrl: json['logoUrl'] as String,
      dots: json['dots'] as int,
      distributorId: json['distributorId'] as int,
      isSelect: json['isSelect'] as bool? ?? false,
    );

Map<String, dynamic> _$DrugModelToJson(DrugModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'activePrinciple': instance.activePrinciple,
      'logoUrl': instance.logoUrl,
      'dots': instance.dots,
      'distributorId': instance.distributorId,
      'isSelect': instance.isSelect,
    };
