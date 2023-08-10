import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kenz_app/models/uom_model/uom_data_list_model.dart';

import 'product_data_model.dart';

part 'product_data_list_model.g.dart';
@HiveType(typeId: 6)

@JsonSerializable(explicitToJson: true)
class ProductDataListModel{
  @HiveField(0) final String? No;
  @HiveField(1) final String? Description;
  @HiveField(2) final String? BaseUnitOfMeasure;
  ProductDataListModel({this.No, this.Description, this.BaseUnitOfMeasure,
  });

  factory ProductDataListModel.fromJson(Map<String, dynamic> json) => _$ProductDataListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDataListModelToJson(this);
}