import 'package:json_annotation/json_annotation.dart';
import 'package:payback/app/src/modules/home/models/prescribe/drug_model.dart';

part 'prescribe_model.g.dart';

@JsonSerializable()
class PrescribeModel {
  final int id;
  final String code;
  final String? imgUrl;
  final String created_at;
  final List<DrugModel> drugs;
  final int companyId;

  PrescribeModel({
    required this.id,
    required this.code,
    required this.imgUrl,
    required this.created_at,
    required this.drugs,
    required this.companyId,
  });

  factory PrescribeModel.fromJson(Map<String, dynamic> json) =>
      _$PrescribeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescribeModelToJson(this);
}
