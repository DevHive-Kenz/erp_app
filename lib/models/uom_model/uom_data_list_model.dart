import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'uom_data_list_model.g.dart';
@HiveType(typeId: 2)

@JsonSerializable(explicitToJson: true)
class UOMDataListModel{
  @HiveField(0) final DateTime? Timestamp;
  @HiveField(1) final String? ItemNO;
  @HiveField(2) final String? Code;
  @HiveField(3) final int? QtyPerUnitOfMeasure;
  UOMDataListModel({
    this.Timestamp, this.ItemNO, this.Code, this.QtyPerUnitOfMeasure,

  });
  factory UOMDataListModel.fromJson(Map<String, dynamic> json) => _$UOMDataListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UOMDataListModelToJson(this);
}