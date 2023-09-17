import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/profile_model/profile_result_model.dart';
import 'package:kenz_app/models/sales_return_model/sales_return_result_model.dart';


part 'sales_return_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesReturnModel {
  final int? status;
  final List<SalesReturnResultModel>? result;
  SalesReturnModel({this.result, this.status});


  factory SalesReturnModel.fromJson(Map<String, dynamic> json) =>
      _$SalesReturnModelFromJson(json);
  Map<String, dynamic> toJson() => _$SalesReturnModelToJson(this);
}
