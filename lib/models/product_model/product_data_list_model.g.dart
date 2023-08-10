// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_data_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductDataListModelAdapter extends TypeAdapter<ProductDataListModel> {
  @override
  final int typeId = 6;

  @override
  ProductDataListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductDataListModel(
      No: fields[0] as String?,
      Description: fields[1] as String?,
      BaseUnitOfMeasure: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductDataListModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.No)
      ..writeByte(1)
      ..write(obj.Description)
      ..writeByte(2)
      ..write(obj.BaseUnitOfMeasure);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDataListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDataListModel _$ProductDataListModelFromJson(
        Map<String, dynamic> json) =>
    ProductDataListModel(
      No: json['No'] as String?,
      Description: json['Description'] as String?,
      BaseUnitOfMeasure: json['BaseUnitOfMeasure'] as String?,
    );

Map<String, dynamic> _$ProductDataListModelToJson(
        ProductDataListModel instance) =>
    <String, dynamic>{
      'No': instance.No,
      'Description': instance.Description,
      'BaseUnitOfMeasure': instance.BaseUnitOfMeasure,
    };
