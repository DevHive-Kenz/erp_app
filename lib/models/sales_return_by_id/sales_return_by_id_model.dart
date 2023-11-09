import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/profile_model/profile_result_model.dart';
import 'package:kenz_app/models/sales_return_by_id/sales_return_result_by_id_model.dart';
import 'package:kenz_app/models/sales_return_model/sales_return_result_model.dart';


part 'sales_return_by_id_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesReturnByIDModel {
  final int? status;
  final SalesReturnByIdResultModel? result;
  SalesReturnByIDModel({this.result, this.status});


  factory SalesReturnByIDModel.fromJson(Map<String, dynamic> json) =>
      _$SalesReturnByIDModelFromJson(json);
  Map<String, dynamic> toJson() => _$SalesReturnByIDModelToJson(this);
}
