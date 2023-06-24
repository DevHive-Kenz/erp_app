import 'package:json_annotation/json_annotation.dart';

import 'branch_list_result_model.dart';

part 'branch_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BranchListModel {
  final int? status;
  final String? message;
  final List<BranchListResultModel?>? result;

  BranchListModel({
    this.status,
    this.message,
    this.result,
  });

  factory BranchListModel.fromJson(Map<String, dynamic> json) =>
      _$BranchListModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchListModelToJson(this);
}
