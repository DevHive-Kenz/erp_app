import 'package:json_annotation/json_annotation.dart';

part 'employee_result_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EmployeeListResultModel {
  final int? id;
  @JsonKey(name: "employee_iqama") final String? employeeIqama;
  @JsonKey(name: "employee_name") final String? employeeName;
  final int? company;
  final int? branch;
  final int? user;

  EmployeeListResultModel({
    this.id,
    this.employeeIqama,
    this.employeeName,
    this.company,
    this.branch,
    this.user,
  });

  factory EmployeeListResultModel.fromJson(
      Map<String, dynamic> json) =>
      _$EmployeeListResultModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EmployeeListResultModelToJson(this);
}
