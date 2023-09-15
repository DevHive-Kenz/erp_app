import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/product_model/product_result_model.dart';
import 'package:kenz_app/models/profile_model/profile_result_model.dart';


part 'product_base_price_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductBasePriceDataModel {
  final String? id;
  final String? name;
  @JsonKey(name: "base_low")final String? baseLow;
  @JsonKey(name: "base_max")final String? baseMax;
  @JsonKey(name: "base_standard")final String? baseStandard;

  ProductBasePriceDataModel(
      {this.id, this.name, this.baseLow, this.baseMax, this.baseStandard});


  factory ProductBasePriceDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProductBasePriceDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductBasePriceDataModelToJson(this);
}
