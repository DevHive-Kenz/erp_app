import 'package:json_annotation/json_annotation.dart';



part 'company_list_result_model.g.dart';
@JsonSerializable(explicitToJson: true)
class CompanyListResultModel {
   final int? id;
   final int? user;
   final String? name;

  CompanyListResultModel({
    this.id, this.user, this.name,
  });

  factory CompanyListResultModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyListResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyListResultModelToJson(this);
}
