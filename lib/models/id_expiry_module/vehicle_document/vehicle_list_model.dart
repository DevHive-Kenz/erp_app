import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/id_expiry_module/vehicle_document/vehicle_result_list_model.dart';

part 'vehicle_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VehicleListModel {
  final int? status;
  final String? message;
  final List<VehicleListResultModel>? result;

  VehicleListModel({
    this.status,
    this.message,
    this.result,
  });

  factory VehicleListModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleListModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleListModelToJson(this);
}
