import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/product_model/product_result_model.dart';
import 'package:kenz_app/models/profile_model/profile_result_model.dart';


part 'total_invoice_items_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TotalInvoiceItemsModel {
  final int? id;
  @JsonKey(name: "sale_id")final int? saleId;
  @JsonKey(name: "item")final String? item;
  @JsonKey(name: "quantity")final double? quantity;
  @JsonKey(name: "unit")final String? unit;
  @JsonKey(name: "price")final double? price;
  @JsonKey(name: "tax")final double? tax;
  @JsonKey(name: "tax_amount")final double? taxAmount;
  @JsonKey(name: "discount")final double? discount;
  @JsonKey(name: "discount_amount")final double? discountAmount;
  @JsonKey(name: "total_amount")final double? totalAmount;

  TotalInvoiceItemsModel({
    this.id,
    this.saleId,
    this.item,
    this.quantity,
    this.unit,
    this.price,
    this.tax,
    this.taxAmount,
    this.discount,
    this.discountAmount,
    this.totalAmount,
  });



  factory TotalInvoiceItemsModel.fromJson(Map<String, dynamic> json) =>
      _$TotalInvoiceItemsModelFromJson(json);
  Map<String, dynamic> toJson() => _$TotalInvoiceItemsModelToJson(this);



}
