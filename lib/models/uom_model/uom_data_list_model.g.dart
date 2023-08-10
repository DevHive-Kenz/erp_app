// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uom_data_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UOMDataListModelAdapter extends TypeAdapter<UOMDataListModel> {
  @override
  final int typeId = 2;

  @override
  UOMDataListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UOMDataListModel(
      Timestamp: fields[0] as DateTime?,
      ItemNO: fields[1] as String?,
      Code: fields[2] as String?,
      QtyPerUnitOfMeasure: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UOMDataListModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.Timestamp)
      ..writeByte(1)
      ..write(obj.ItemNO)
      ..writeByte(2)
      ..write(obj.Code)
      ..writeByte(3)
      ..write(obj.QtyPerUnitOfMeasure);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UOMDataListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UOMDataListModel _$UOMDataListModelFromJson(Map<String, dynamic> json) =>
    UOMDataListModel(
      Timestamp: json['Timestamp'] == null
          ? null
          : DateTime.parse(json['Timestamp'] as String),
      ItemNO: json['ItemNO'] as String?,
      Code: json['Code'] as String?,
      QtyPerUnitOfMeasure: json['QtyPerUnitOfMeasure'] as int?,
    );

Map<String, dynamic> _$UOMDataListModelToJson(UOMDataListModel instance) =>
    <String, dynamic>{
      'Timestamp': instance.Timestamp?.toIso8601String(),
      'ItemNO': instance.ItemNO,
      'Code': instance.Code,
      'QtyPerUnitOfMeasure': instance.QtyPerUnitOfMeasure,
    };
