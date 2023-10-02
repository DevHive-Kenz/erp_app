import 'package:json_annotation/json_annotation.dart';

import 'master_data_result_model.dart';



part 'master_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MasterDataModel {
  final int? status;
  final MasterDataResultModel? result;
  MasterDataModel({this.result, this.status});
  factory MasterDataModel.fromJson(Map<String, dynamic> json) =>
      _$MasterDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MasterDataModelToJson(this);
}
