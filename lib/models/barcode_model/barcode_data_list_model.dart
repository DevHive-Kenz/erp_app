import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'barcode_data_list_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(explicitToJson: true)
class BarcodeDataListModel {
  @HiveField(0)
  final String? BarcodeNo;
  @HiveField(1)
  final String? ItemNO;
  @HiveField(2)
  final String? UnitOfMeasureCode;
  BarcodeDataListModel({
    this.BarcodeNo,
    this.ItemNO,
    this.UnitOfMeasureCode,
  });
  factory BarcodeDataListModel.fromJson(Map<String, dynamic> json) =>
      _$BarcodeDataListModelFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeDataListModelToJson(this);
}
