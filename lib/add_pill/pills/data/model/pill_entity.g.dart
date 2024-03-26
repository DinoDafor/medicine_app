// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pill_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PillEntityAdapter extends TypeAdapter<PillEntity> {
  @override
  final int typeId = 0;

  @override
  PillEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PillEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      countOfPills: fields[2] as int,
      repetition: fields[3] as String,
      timeToDrink: fields[4] as DateTime,
      specificToDrink: fields[5] as int,
      description: fields[6] as String,
      status: fields[7] as StatusEnum,
      image: fields[8] as FormEnum,
    );
  }

  @override
  void write(BinaryWriter writer, PillEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.countOfPills)
      ..writeByte(3)
      ..write(obj.repetition)
      ..writeByte(4)
      ..write(obj.timeToDrink)
      ..writeByte(5)
      ..write(obj.specificToDrink)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PillEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
