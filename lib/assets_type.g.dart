// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssetAdapter extends TypeAdapter<Asset> {
  @override
  final int typeId = 1;

  @override
  Asset read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Asset(
      httpUrl: fields[0] as String,
      localUrl: fields[1] as String,
      isDownloaded: fields[2] as bool,
      filename: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Asset obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.httpUrl)
      ..writeByte(1)
      ..write(obj.localUrl)
      ..writeByte(2)
      ..write(obj.isDownloaded)
      ..writeByte(3)
      ..write(obj.filename);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
