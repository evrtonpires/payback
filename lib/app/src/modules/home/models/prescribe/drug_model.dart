import 'package:json_annotation/json_annotation.dart';

part 'drug_model.g.dart';

@JsonSerializable()
class DrugModel {
  final int id;
  final String name;
  final String activePrinciple;
  final String logoUrl;
  final int dots;
  final int distributorId;
  late bool isSelect;

  DrugModel({
    required this.id,
    required this.name,
    required this.activePrinciple,
    required this.logoUrl,
    required this.dots,
    required this.distributorId,
    this.isSelect = false,
  });

  factory DrugModel.fromJson(Map<String, dynamic> json) =>
      _$DrugModelFromJson(json);

  Map<String, dynamic> toJson() => _$DrugModelToJson(this);
}
