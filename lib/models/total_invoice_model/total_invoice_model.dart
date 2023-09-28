import 'package:json_annotation/json_annotation.dart';

import 'package:kenz_app/models/total_invoice_model/total_invoice_result_model.dart';


part 'total_invoice_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TotalInvoiceModel {
  final int? status;
  final List<TotalInvoiceResultModel>? result;
  TotalInvoiceModel({this.result, this.status});


  factory TotalInvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$TotalInvoiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$TotalInvoiceModelToJson(this);
}
