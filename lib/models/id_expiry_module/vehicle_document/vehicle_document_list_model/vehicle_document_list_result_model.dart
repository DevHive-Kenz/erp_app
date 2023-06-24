import 'package:json_annotation/json_annotation.dart';

part 'vehicle_document_list_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VehicleDocumentListResultModel {
  final int? id;
  @JsonKey(name: 'document_type')
  final String? documentType;
  @JsonKey(name: 'document_id')
  final String? documentId;
  final String? expiry;
  final int? company;
  final int? branch;
  final int? vehicle;

  VehicleDocumentListResultModel({
    this.id,
    this.documentType,
    this.documentId,
    this.expiry,
    this.company,
    this.branch,
    this.vehicle,
  });

  factory VehicleDocumentListResultModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleDocumentListResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDocumentListResultModelToJson(this);
}
