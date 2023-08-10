// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodeDataModelAdapter extends TypeAdapter<BarcodeDataModel> {
  @override
  final int typeId = 3;

  @override
  BarcodeDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodeDataModel(
      Entities: (fields[3] as List?)?.cast<BarcodeDataListModel>(),
      Skip: fields[1] as int?,
      Take: fields[2] as int?,
      TotalCount: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BarcodeDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.TotalCount)
      ..writeByte(1)
      ..write(obj.Skip)
      ..writeByte(2)
      ..write(obj.Take)
      ..writeByte(3)
      ..write(obj.Entities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarcodeDataModel _$BarcodeDataModelFromJson(Map<String, dynamic> json) =>
    BarcodeDataModel(
      Entities: (json['Entities'] as List<dynamic>?)
          ?.map((e) => BarcodeDataListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      Skip: json['Skip'] as int?,
      Take: json['Take'] as int?,
      TotalCount: json['TotalCount'] as int?,
    );

Map<String, dynamic> _$BarcodeDataModelToJson(BarcodeDataModel instance) =>
    <String, dynamic>{
      'TotalCount': instance.TotalCount,
      'Skip': instance.Skip,
      'Take': instance.Take,
      'Entities': instance.Entities?.map((e) => e.toJson()).toList(),
    };
