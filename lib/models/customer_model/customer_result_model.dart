import 'package:json_annotation/json_annotation.dart';

part 'customer_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerResultModel {
  final int? id;
  @JsonKey(name: "user_id")final int? userID;
  final String? name;
  @JsonKey(name: "name_a")final String? nameArabic;
  final String? address1;
  @JsonKey(name: "address1_a")final String? address1A;
  final String? address2;
  @JsonKey(name: "address2_a")final String? address2A;
  @JsonKey(name: "crn_number")final String? crnNumber;
  @JsonKey(name: "is_customer")final bool? isCustomer;
  @JsonKey(name: "is_vendor")final bool? isVendor;
  @JsonKey(name: "is_employee")final bool? isEmployee;
  @JsonKey(name: "is_rep")final bool? isRep;
  @JsonKey(name: "route_id")final int? routeId;
  @JsonKey(name: "region_id")final int? regionId;
  @JsonKey(name: "rep_id")final int? repId;
  @JsonKey(name: "tax_id")final String? taxId;
  @JsonKey(name: "group_id")final int? groupId;
  @JsonKey(name: "price_list")final String? priceList;


  CustomerResultModel(
      {
    this.id,
    this.userID,
    this.name,
    this.nameArabic,
    this.address1,
    this.address1A,
    this.address2,
    this.address2A,
    this.crnNumber,
    this.isCustomer,
    this.isVendor,
    this.isEmployee,
    this.isRep,
    this.routeId,
    this.regionId,
    this.repId,
    this.taxId,
    this.groupId,
    this.priceList,
  });
  factory CustomerResultModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResultModelToJson(this);
}
