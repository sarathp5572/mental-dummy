// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alaram_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmInfoAdapter extends TypeAdapter<AlarmInfo> {
  @override
  final int typeId = 1;

  @override
  AlarmInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmInfo(
      id: fields[0] as int?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      startDate: fields[3] as String?,
      endDate: fields[4] as String?,
      startTime: fields[5] as String?,
      endTime: fields[6] as String?,
      repeat: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AlarmInfo obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.startTime)
      ..writeByte(6)
      ..write(obj.endTime)
      ..writeByte(7)
      ..write(obj.repeat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
