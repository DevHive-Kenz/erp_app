import 'package:json_annotation/json_annotation.dart';
import 'package:kenz_app/models/profile_model/profile_result_model.dart';


part 'profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileModel {
  final int? status;
  final List<ProfileResultModel>? result;
  ProfileModel({this.result, this.status});


  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
