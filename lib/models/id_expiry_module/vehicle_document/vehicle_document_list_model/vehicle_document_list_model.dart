import 'package:json_annotation/json_annotation.dart';
import 'vehicle_document_list_result_model.dart';

part 'vehicle_document_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VehicleDocumentListModel {
  final int? status;
  final String? message;
  final List<VehicleDocumentListResultModel>? result;

  VehicleDocumentListModel({
    this.status,
    this.message,
    this.result,
  });

  factory VehicleDocumentListModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleDocumentListModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDocumentListModelToJson(this);
}
