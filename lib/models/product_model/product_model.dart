import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/product_model/product_result_model.dart';
import 'package:kenz_app/models/profile_model/profile_result_model.dart';


part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel {
  final int? status;
  final List<ProductResultModel>? result;
  ProductModel({this.result, this.status});


  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
