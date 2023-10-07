import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/profile_model/profile_result_model.dart';
import 'package:kenz_app/models/sales_return_model/sales_return_items_model.dart';

import '../customer_model/customer_result_model.dart';
import '../total_invoice_model/total_invoice_items_model.dart';


part 'sales_return_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesReturnResultModel {
  final int? id;
  @JsonKey(name: "user_id")final int? userId;
  @JsonKey(name: "sold_to_id")final int? soldToId;
  @JsonKey(name: "branch_id")final int? branchID;
  @JsonKey(name: "print_type")final String? printType;
  @JsonKey(name: "image_file")final String? imageFile;
  @JsonKey(name: "document_file")final String? documentFile;
  @JsonKey(name: "invoice_id")final int? invoiceId;
  @JsonKey(name: "payment_type")final String? paymentType;
  @JsonKey(name: "amount")final num? amount;
  @JsonKey(name: "total_tax")final num? totalTax;
  @JsonKey(name: "date")final DateTime? date;
  @JsonKey(name: "quotation_id")final int? quotationId;
  @JsonKey(name: "supply_date")final String? supplyDate;
  @JsonKey(name: "contract_number")final String? contractNumber;
  @JsonKey(name: "due_date")final String? dueDate;
  @JsonKey(name: "invoice_period")final String? invoicePeriod;
  @JsonKey(name: "reference_number")final String? referenceNumber;
  @JsonKey(name: "prepared_by")final String? preparedBy;
  @JsonKey(name: "approved_by")final String? approvedBy;
  @JsonKey(name: "customer_data")final CustomerResultModel? customerData;
  final List<TotalInvoiceItemsModel>? items;
  SalesReturnResultModel(
      {this.id,
      this.userId,
        this.branchID, this.customerData,
        this.soldToId,
      this.printType,
      this.imageFile,
      this.documentFile,
      this.invoiceId,
      this.paymentType,
      this.amount,
      this.totalTax,
      this.date,
      this.quotationId,
      this.supplyDate,
      this.contractNumber,
      this.dueDate,
      this.invoicePeriod,
      this.referenceNumber,
      this.preparedBy,
      this.approvedBy,
      this.items,
    });


  factory SalesReturnResultModel.fromJson(Map<String, dynamic> json) =>
      _$SalesReturnResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$SalesReturnResultModelToJson(this);
}
