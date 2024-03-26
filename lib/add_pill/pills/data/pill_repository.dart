import 'package:medicine_app/add_pill/pills/data/model/enums/status_enum.dart';

import 'model/pill_entity.dart';

abstract class PillRepository {
  Future<List<PillEntity>> getAllPills(DateTime date);
  deletePill(String id);
  addPill(PillEntity pill);
  updateStatus(String id, StatusEnum status);
}
