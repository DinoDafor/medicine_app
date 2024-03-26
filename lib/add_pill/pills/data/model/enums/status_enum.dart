import 'package:hive/hive.dart';

part 'status_enum.g.dart';

@HiveType(typeId: 1)
enum StatusEnum {
   @HiveField(0)
  ATTENTION,
  @HiveField(1)
  NOT_OKAY,
  @HiveField(2)
  OKAY,
  
 
}

Map<StatusEnum, String> statusPill = {
  StatusEnum.ATTENTION: 'assets/images/attention.png',
  StatusEnum.OKAY: 'assets/images/okay.png',
  StatusEnum.NOT_OKAY: 'assets/images/notokay.png',
  
};
