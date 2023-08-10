import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kenz_app/models/uom_model/uom_data_list_model.dart';

part 'uom_data_model.g.dart';
@HiveType(typeId: 1)

@JsonSerializable(explicitToJson: true)
class UOMDataModel{
  @HiveField(0) final int? TotalCount;
  @HiveField(1) final int? Skip;
  @HiveField(2) final int? Take;
  @HiveField(3) final List<UOMDataListModel>? Entities;
  UOMDataModel({
this.Entities,
    this.Skip,
    this.Take,
    this.TotalCount
  });
  factory UOMDataModel.fromJson(Map<String, dynamic> json) => _$UOMDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UOMDataModelToJson(this);
}