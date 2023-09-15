import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/product_model/product_result_model.dart';
import 'package:kenz_app/models/profile_model/profile_result_model.dart';


part 'product_items_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductItemsModel {
  @JsonKey(name: "low_limit_price")final String? lowLimitPrice;
  @JsonKey(name: "max_limit_price")final String? maxLimitPrice;
  @JsonKey(name: "standard_limit_price")final String? standardLimitPrice;
  final int? id;
  ProductItemsModel(
      {this.lowLimitPrice,
      this.maxLimitPrice,
      this.standardLimitPrice,
      this.id});


  factory ProductItemsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductItemsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductItemsModelToJson(this);
}
