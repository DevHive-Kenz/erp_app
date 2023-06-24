import 'package:json_annotation/json_annotation.dart';

import 'employee_document_list_result_model.dart';

part 'employee_document_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EmployeeDocumentListModel {
  final int? status;
  final String? message;
  final List<EmployeeDocumentListResultModel>? result;

  EmployeeDocumentListModel({
    this.status,
    this.message,
    this.result,
  });

  factory EmployeeDocumentListModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDocumentListModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDocumentListModelToJson(this);
}
