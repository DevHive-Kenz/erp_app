import 'package:json_annotation/json_annotation.dart';

import 'customer_result_model.dart';

part 'customer_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerModel {
  final int? status;
  final List<CustomerResultModel>? result;
  CustomerModel({this.result, this.status});
  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
