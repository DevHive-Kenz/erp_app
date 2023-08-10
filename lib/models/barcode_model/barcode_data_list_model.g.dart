// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_data_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodeDataListModelAdapter extends TypeAdapter<BarcodeDataListModel> {
  @override
  final int typeId = 4;

  @override
  BarcodeDataListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodeDataListModel(
      BarcodeNo: fields[0] as String?,
      ItemNO: fields[1] as String?,
      UnitOfMeasureCode: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BarcodeDataListModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.BarcodeNo)
      ..writeByte(1)
      ..write(obj.ItemNO)
      ..writeByte(2)
      ..write(obj.UnitOfMeasureCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeDataListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarcodeDataListModel _$BarcodeDataListModelFromJson(
        Map<String, dynamic> json) =>
    BarcodeDataListModel(
      BarcodeNo: json['BarcodeNo'] as String?,
      ItemNO: json['ItemNO'] as String?,
      UnitOfMeasureCode: json['UnitOfMeasureCode'] as String?,
    );

Map<String, dynamic> _$BarcodeDataListModelToJson(
        BarcodeDataListModel instance) =>
    <String, dynamic>{
      'BarcodeNo': instance.BarcodeNo,
      'ItemNO': instance.ItemNO,
      'UnitOfMeasureCode': instance.UnitOfMeasureCode,
    };
