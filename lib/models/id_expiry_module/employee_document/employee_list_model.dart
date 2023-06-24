import 'package:json_annotation/json_annotation.dart';
import 'employee_result_list_model.dart';

part 'employee_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EmployeeListModel {
  final List<EmployeeListResultModel>? result;
  final String? message;
  final int? status;

  EmployeeListModel({
    this.result,
    this.message,
    this.status,
  });

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeListModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeListModelToJson(this);
}
