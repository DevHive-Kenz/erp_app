import 'package:json_annotation/json_annotation.dart';

import 'master_data_values_model.dart';



part 'master_data_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MasterDataResultModel {
  final List<MasterDataValueModel>? rep;
  final List<MasterDataValueModel>? group;
 @JsonKey(name:"Region") final List<MasterDataValueModel>? region;
  @JsonKey(name:"Route") final List<MasterDataValueModel>? route;
  @JsonKey(name:"price_list") final List<MasterDataValueModel>? priceList;

  MasterDataResultModel(
      {this.rep, this.group, this.region, this.route, this.priceList});
  factory MasterDataResultModel.fromJson(Map<String, dynamic> json) =>
      _$MasterDataResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$MasterDataResultModelToJson(this);
}
