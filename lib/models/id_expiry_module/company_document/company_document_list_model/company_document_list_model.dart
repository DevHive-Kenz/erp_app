import 'package:json_annotation/json_annotation.dart';

import 'company_document_list_result_model.dart';

part 'company_document_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyDocumentListModel {
  final int? status;
  final String? message;
  final List<CompanyDocumentResultListModel>? result;

  CompanyDocumentListModel({
    this.status,
    this.message,
    this.result,
  });

  factory CompanyDocumentListModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyDocumentListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDocumentListModelToJson(this);
}
