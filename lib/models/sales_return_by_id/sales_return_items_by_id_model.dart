import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/profile_model/profile_result_model.dart';


part 'sales_return_items_by_id_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesReturnByIdItemModel {
  final int? id;
  @JsonKey(name: "sale_id") final int? saleId;
  final String? item;
  final String? unit;
  final num? price;
  final num? quantity;
  final num? tax;
  @JsonKey(name: "tax_amount")final num? taxAmount;
  final num? discount;
  @JsonKey(name: "discount_amount")final num? discountAmount;
  @JsonKey(name: "total_amount")final num? totalAmount;

  SalesReturnByIdItemModel(
      {this.id,
      this.saleId,
      this.item,
      this.unit,
      this.price,
      this.quantity,
      this.tax,
      this.taxAmount,
      this.discount,
      this.discountAmount,
      this.totalAmount});
  factory SalesReturnByIdItemModel.fromJson(Map<String, dynamic> json) =>
      _$SalesReturnByIdItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$SalesReturnByIdItemModelToJson(this);
}
