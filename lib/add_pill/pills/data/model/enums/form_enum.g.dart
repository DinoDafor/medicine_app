// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormEnumAdapter extends TypeAdapter<FormEnum> {
  @override
  final int typeId = 2;

  @override
  FormEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FormEnum.DIASEPAM;
      case 1:
        return FormEnum.IBUPROFEN;
      case 2:
        return FormEnum.KLONASEPAM;
      case 3:
        return FormEnum.PHENOBARBITAL;
      default:
        return FormEnum.DIASEPAM;
    }
  }

  @override
  void write(BinaryWriter writer, FormEnum obj) {
    switch (obj) {
      case FormEnum.DIASEPAM:
        writer.writeByte(0);
        break;
      case FormEnum.IBUPROFEN:
        writer.writeByte(1);
        break;
      case FormEnum.KLONASEPAM:
        writer.writeByte(2);
        break;
      case FormEnum.PHENOBARBITAL:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
