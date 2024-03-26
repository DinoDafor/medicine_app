import 'package:hive/hive.dart';
import 'package:medicine_app/add_pill/pills/data/model/enums/form_enum.dart';
import 'package:medicine_app/add_pill/pills/data/model/enums/status_enum.dart';

part 'pill_entity.g.dart';

@HiveType(typeId: 0)
class PillEntity extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int countOfPills;
  @HiveField(3)
  final String repetition;
  @HiveField(4)
  final DateTime timeToDrink;
  @HiveField(5)
  final int specificToDrink;
  @HiveField(6)
  final String description;
  @HiveField(7)
  StatusEnum status;
  @HiveField(8)
  final FormEnum image;

  PillEntity({
    required this.id,
    required this.name,
    required this.countOfPills,
    required this.repetition,
    required this.timeToDrink,
    required this.specificToDrink,
    required this.description,
    required this.status,
    required this.image,
  });
}
