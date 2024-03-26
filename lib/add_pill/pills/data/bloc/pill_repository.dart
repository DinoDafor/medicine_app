import 'package:hive/hive.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_entity.dart';

class PillRepository {
  Future<List<PillEntity>> loadCachedPills() async {
    var box = await Hive.openBox<PillEntity>('pillbox');
    var boxPills = box.get("Pills");
    print(boxPills);
    return box.values.toList();
  }
}
