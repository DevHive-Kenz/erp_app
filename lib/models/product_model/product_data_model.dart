import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kenz_app/models/product_model/product_data_list_model.dart';
import 'package:kenz_app/models/uom_model/uom_data_list_model.dart';

import 'product_data_model.dart';

part 'product_data_model.g.dart';
@HiveType(typeId: 5)

@JsonSerializable(explicitToJson: true)
class ProductDataModel{
  @HiveField(0) final int? TotalCount;
  @HiveField(1) final int? Skip;
  @HiveField(2) final int? Take;
  @HiveField(3) final List<ProductDataListModel>? Entities;
  ProductDataModel({
    this.Entities,
    this.Skip,
    this.Take,
    this.TotalCount
  });
  factory ProductDataModel.fromJson(Map<String, dynamic> json) => _$ProductDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataModelToJson(this);
}