import 'package:json_annotation/json_annotation.dart';

part 'branch_list_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BranchListResultModel {
  final int? id;
  final String? name;
  final int? company;

  BranchListResultModel({
    this.id,
    this.name,
    this.company,
  });

  factory BranchListResultModel.fromJson(Map<String, dynamic> json) =>
      _$BranchListResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchListResultModelToJson(this);
}
