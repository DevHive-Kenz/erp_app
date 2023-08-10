import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kenz_app/models/uom_model/uom_data_list_model.dart';

import 'barcode_data_list_model.dart';

part 'barcode_data_model.g.dart';
@HiveType(typeId: 3)

@JsonSerializable(explicitToJson: true)
class BarcodeDataModel{
  @HiveField(0) final int? TotalCount;
  @HiveField(1) final int? Skip;
  @HiveField(2) final int? Take;
  @HiveField(3) final List<BarcodeDataListModel>? Entities;
  BarcodeDataModel({
    this.Entities,
    this.Skip,
    this.Take,
    this.TotalCount
  });
  factory BarcodeDataModel.fromJson(Map<String, dynamic> json) => _$BarcodeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeDataModelToJson(this);
}