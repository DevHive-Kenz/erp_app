import 'package:json_annotation/json_annotation.dart';

part 'company_document_list_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyDocumentResultListModel {
  final int? id;
  @JsonKey(name: "document_type")final String? documentType;
  @JsonKey(name: "document_number")final String? documentNumber;
  final String? expiry;
  final int? company;
  final int? branch;

  CompanyDocumentResultListModel({
    this.id,
    this.documentType,
    this.documentNumber,
    this.expiry,
    this.company,
    this.branch,
  });

  factory CompanyDocumentResultListModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyDocumentResultListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDocumentResultListModelToJson(this);
}
