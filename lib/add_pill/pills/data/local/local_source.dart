import 'package:hive/hive.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_entity.dart';

import '../model/enums/status_enum.dart';

abstract class PillLocalDataSource {
  /// Gets the cached [List<PersonModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.

  Future<List<PillEntity>> getLastPillFromCache();
  Future<void> pillsToCache(PillEntity pill);
  Future<void> deleteToCash(String id);
  Future<void> updateToCash(String id, StatusEnum status);
}

class PillLocalDataSourceImpl implements PillLocalDataSource {
  @override
  Future<List<PillEntity>> getLastPillFromCache() async {
    var box = await Hive.openBox<PillEntity>('pillbox');
    return await box.values.toList();
  }

  @override
  Future<void> pillsToCache(PillEntity pill) async {
    var box = await Hive.openBox<PillEntity>('pillbox');
    await box.add(pill);
  }

  @override
  Future<void> deleteToCash(String id) async {
    var box = await Hive.openBox<PillEntity>('pillbox');
    final pillToRemove = box.values.firstWhere((task) => task.id == id);
    await pillToRemove.delete();
  }

  @override
  Future<void> updateToCash(String id, StatusEnum status) async {
    var box = await Hive.openBox<PillEntity>('pillbox');
    final taskToEdit = box.values.firstWhere((task) => task.id == id);
    final index = taskToEdit.key as int;
    taskToEdit.status = status;
    await box.put(index, taskToEdit);
  }
}
