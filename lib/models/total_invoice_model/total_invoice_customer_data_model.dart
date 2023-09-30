import 'package:json_annotation/json_annotation.dart';

import 'package:kenz_app/models/sales_return_model/sales_return_result_model.dart';
import 'package:kenz_app/models/total_invoice_model/total_invoice_items_model.dart';


part 'total_invoice_customer_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TotalInvoiceCustomerDataModel {
  final int? id;
  @JsonKey(name: "user_id")final int? userId;
  @JsonKey(name: "date")final String? date;
  @JsonKey(name: "name")final String? name;
  @JsonKey(name: "name_a")final String? nameA;
  @JsonKey(name: "address1")final String? address1;
  @JsonKey(name: "address1_a")final String? address1A;
  @JsonKey(name: "address2")final String? address2;
  @JsonKey(name: "address2_a")final String? address2A;
  @JsonKey(name: "crn_number")final String? crnNumber;
  @JsonKey(name: "vat_number")final String? vatNumber;
  @JsonKey(name: "is_customer")final bool? isCustomer;
  @JsonKey(name: "is_vendor")final bool? isVendor;
  @JsonKey(name: "is_employee")final bool? isEmployee;
  @JsonKey(name: "is_rep")final bool? isRep;
  // @JsonKey(name: "route_id")final int? routeId;
  @JsonKey(name: "region_id")final int? regionId;
  @JsonKey(name: "rep_id")final int? repId;
  @JsonKey(name: "tax_id")final String? taxId;
  @JsonKey(name: "group_id")final int? groupId;
  // @JsonKey(name: "price_list_id")final int? priceListId;


  TotalInvoiceCustomerDataModel(
      {this.id,
      this.userId,
      this.date,
      this.name,
      this.nameA,
      this.address1,
      this.address1A,
      this.address2,
      this.address2A,
      this.crnNumber,
      this.vatNumber,
      this.isCustomer,
      this.isVendor,
      this.isEmployee,
      this.isRep,
      this.regionId,
      this.repId,
      this.taxId,
      this.groupId});


  factory TotalInvoiceCustomerDataModel.fromJson(Map<String, dynamic> json) => _$TotalInvoiceCustomerDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$TotalInvoiceCustomerDataModelToJson(this);
}
