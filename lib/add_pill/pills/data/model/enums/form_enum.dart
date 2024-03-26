import 'package:hive/hive.dart';

part 'form_enum.g.dart';

@HiveType(typeId: 2)
enum FormEnum {
  @HiveField(0)
  DIASEPAM,
  @HiveField(1)
  IBUPROFEN,
  @HiveField(2)
  KLONASEPAM,
  @HiveField(3)
  PHENOBARBITAL
}

Map<FormEnum, String> imagesPill = {
  FormEnum.DIASEPAM: 'assets/images/diasepam.png',
  FormEnum.IBUPROFEN: 'assets/images/ibuprofen.png',
  FormEnum.KLONASEPAM: 'assets/images/clonasepam.png',
  FormEnum.PHENOBARBITAL: 'assets/images/phenobarbital.png'
};
