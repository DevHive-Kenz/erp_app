import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/product_model/product_base_price_data_model.dart';
import 'package:kenz_app/models/product_model/product_items_model.dart';
import 'package:kenz_app/models/product_model/product_unit_conversion_model.dart';
import 'package:kenz_app/models/profile_model/profile_result_model.dart';


part 'product_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductResultModel {
  final int? id;
  final String? sku;
  final DateTime? added;
  @JsonKey(name: "user_id") final int? userID;
  @JsonKey(name: "name") final String? name;
  @JsonKey(name: "name_arabic") final String? nameArabic;
  @JsonKey(name: "image") final String? image;
  @JsonKey(name: "category_id") final int? categoryId;
  @JsonKey(name: "item_code") final String? itemCode;
  @JsonKey(name: "base_unit_id") final int? baseUnitId;
  @JsonKey(name: "base_unit_name") final String? baseUnitName;
  @JsonKey(name: "tax_category_id") final int? taxCategoryId;
  @JsonKey(name: "bln_active") final bool? blnActive;
  @JsonKey(name: "bln_stocked") final bool? blnStocked;
  @JsonKey(name: "bln_manufactured") final bool? blnManufactured;
  @JsonKey(name: "bln_purchased") final bool? blnPurchased;
  @JsonKey(name: "bln_sold") final bool? blnSold;
  @JsonKey(name: "product_type_id") final int? productTypeId;
  @JsonKey(name: "discount_type") final String? discountType;
  @JsonKey(name: "discount") final num? discount;
  @JsonKey(name: "discounted_price") final num? discountedPrice;
  @JsonKey(name: "price") final num? price;
  @JsonKey(name: "bar_code") final List? barCode;
  @JsonKey(name: "base_price_data") final List<ProductItemsModel>? basePriceData;
  @JsonKey(name: "unit_conversion_data") final List<ProductUnitConversionDataModel>? unitConversionData;


  ProductResultModel(
      {this.id,
        this.baseUnitName,
        this.sku,
      this.added,
      this.userID,
      this.name,
      this.nameArabic,
      this.image,
      this.categoryId,
      this.itemCode,
      this.baseUnitId,
      this.taxCategoryId,
      this.blnActive,
      this.blnStocked,
      this.blnManufactured,
      this.blnPurchased,
      this.blnSold,
      this.productTypeId,
      this.discountType,
      this.discount,
      this.discountedPrice,
      this.price,
      this.barCode,
      this.basePriceData,
      this.unitConversionData});


  factory ProductResultModel.fromJson(Map<String, dynamic> json) =>
      _$ProductResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductResultModelToJson(this);
}
