// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatusEnumAdapter extends TypeAdapter<StatusEnum> {
  @override
  final int typeId = 1;

  @override
  StatusEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 2:
        return StatusEnum.OKAY;
      case 1:
        return StatusEnum.NOT_OKAY;
      case 0:
        return StatusEnum.ATTENTION;
      default:
        return StatusEnum.ATTENTION;
    }
  }

  @override
  void write(BinaryWriter writer, StatusEnum obj) {
    switch (obj) {
      case StatusEnum.OKAY:
        writer.writeByte(2);
        break;
      case StatusEnum.NOT_OKAY:
        writer.writeByte(1);
        break;
      case StatusEnum.ATTENTION:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
