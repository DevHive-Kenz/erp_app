import 'package:json_annotation/json_annotation.dart';



part 'master_data_values_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MasterDataValueModel {
  final int? id;
  final int? user;
  final String? name;


  MasterDataValueModel({this.id, this.user, this.name});
  factory MasterDataValueModel.fromJson(Map<String, dynamic> json) =>
      _$MasterDataValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$MasterDataValueModelToJson(this);
}
