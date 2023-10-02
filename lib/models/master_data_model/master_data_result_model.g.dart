// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_data_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterDataResultModel _$MasterDataResultModelFromJson(
        Map<String, dynamic> json) =>
    MasterDataResultModel(
      rep: (json['rep'] as List<dynamic>?)
          ?.map((e) => MasterDataValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      group: (json['group'] as List<dynamic>?)
          ?.map((e) => MasterDataValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      region: (json['Region'] as List<dynamic>?)
          ?.map((e) => MasterDataValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      route: (json['Route'] as List<dynamic>?)
          ?.map((e) => MasterDataValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceList: (json['price_list'] as List<dynamic>?)
          ?.map((e) => MasterDataValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MasterDataResultModelToJson(
        MasterDataResultModel instance) =>
    <String, dynamic>{
      'rep': instance.rep?.map((e) => e.toJson()).toList(),
      'group': instance.group?.map((e) => e.toJson()).toList(),
      'Region': instance.region?.map((e) => e.toJson()).toList(),
      'Route': instance.route?.map((e) => e.toJson()).toList(),
      'price_list': instance.priceList?.map((e) => e.toJson()).toList(),
    };
