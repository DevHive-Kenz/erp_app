import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/product_model/product_items_model.dart';
import 'package:kenz_app/models/product_model/product_result_model.dart';
import 'package:kenz_app/models/profile_model/profile_result_model.dart';


part 'product_unit_conversion_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductUnitConversionDataModel {
  final String? qty;
  final String? price;
  @JsonKey(name: "to_unit") final String? toUnit;
  @JsonKey(name: "unit_name") final String? toUnitName;
  final List? barcode;
  final List<ProductItemsModel>? items;

  ProductUnitConversionDataModel(
      {this.toUnitName,this.qty, this.price, this.toUnit, this.barcode, this.items});


  factory ProductUnitConversionDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProductUnitConversionDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductUnitConversionDataModelToJson(this);
}
