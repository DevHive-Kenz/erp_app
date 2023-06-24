import 'package:json_annotation/json_annotation.dart';

part 'vehicle_result_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VehicleListResultModel {
  final int? id;
  final String? name;
  @JsonKey(name: 'number_plate') final String? numberPlate;
  final String? model;
  final int? year;
  final int? company;
  final int? branch;

  VehicleListResultModel({
    this.id,
    this.name,
    this.numberPlate,
    this.model,
    this.year,
    this.company,
    this.branch,
  });

  factory VehicleListResultModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleListResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleListResultModelToJson(this);
}
