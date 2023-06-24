import 'package:json_annotation/json_annotation.dart';

import 'company_list_result_model.dart';
part 'company_list_model.g.dart';
@JsonSerializable(explicitToJson: true)
class CompanyListModel{
  final int? status;
  final String? message;
  final List<CompanyListResultModel?>? result;

  CompanyListModel({
    this.status,
    this.message,
    this.result,
});
  factory CompanyListModel.fromJson(Map<String, dynamic> json) => _$CompanyListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyListModelToJson(this);
}