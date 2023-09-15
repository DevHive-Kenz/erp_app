// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerResultModel _$CustomerResultModelFromJson(Map<String, dynamic> json) =>
    CustomerResultModel(
      id: json['id'] as int?,
      userID: json['user_id'] as int?,
      name: json['name'] as String?,
      nameArabic: json['name_a'] as String?,
      address1: json['address1'] as String?,
      address1A: json['address1_a'] as String?,
      address2: json['address2'] as String?,
      address2A: json['address2_a'] as String?,
      crnNumber: json['crn_number'] as String?,
      isCustomer: json['is_customer'] as bool?,
      isVendor: json['is_vendor'] as bool?,
      isEmployee: json['is_employee'] as bool?,
      isRep: json['is_rep'] as bool?,
      routeId: json['route_id'] as int?,
      regionId: json['region_id'] as int?,
      repId: json['rep_id'] as int?,
      taxId: json['tax_id'] as String?,
      groupId: json['group_id'] as int?,
      priceList: json['price_list'] as String?,
    );

Map<String, dynamic> _$CustomerResultModelToJson(
        CustomerResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userID,
      'name': instance.name,
      'name_a': instance.nameArabic,
      'address1': instance.address1,
      'address1_a': instance.address1A,
      'address2': instance.address2,
      'address2_a': instance.address2A,
      'crn_number': instance.crnNumber,
      'is_customer': instance.isCustomer,
      'is_vendor': instance.isVendor,
      'is_employee': instance.isEmployee,
      'is_rep': instance.isRep,
      'route_id': instance.routeId,
      'region_id': instance.regionId,
      'rep_id': instance.repId,
      'tax_id': instance.taxId,
      'group_id': instance.groupId,
      'price_list': instance.priceList,
    };
