import 'package:json_annotation/json_annotation.dart';

part 'employee_document_list_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EmployeeDocumentListResultModel {
  final int? id;
  @JsonKey(name: "document_type")final String? documentType;
  @JsonKey(name: "document_number")final String? documentNumber;
  final String? expiry;
  final int? company;
  final int? branch;
  final int? employee;

  EmployeeDocumentListResultModel({
    this.id,
    this.documentType,
    this.documentNumber,
    this.expiry,
    this.company,
    this.branch,
    this.employee,
  });

  factory EmployeeDocumentListResultModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDocumentListResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDocumentListResultModelToJson(this);
}
