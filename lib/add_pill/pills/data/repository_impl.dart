import 'package:medicine_app/add_pill/pills/data/local/local_source.dart';
import 'package:medicine_app/add_pill/pills/data/model/enums/status_enum.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_entity.dart';
import 'package:medicine_app/add_pill/pills/data/pill_repository.dart';

class RepositoryImpl implements PillRepository {
  final PillLocalDataSource localDataSource;

  RepositoryImpl({required this.localDataSource});

  @override
  addPill(PillEntity pill) async {
    final newPill = PillEntity(
        id: pill.id,
        name: pill.name,
        countOfPills: pill.countOfPills,
        timeToDrink: pill.timeToDrink,
        specificToDrink: pill.specificToDrink,
        description: pill.description,
        repetition: pill.repetition,
        status: pill.status,
        image: pill.image);
    await localDataSource.pillsToCache(newPill);
  }

  @override
  deletePill(String id) async {
    await localDataSource.deleteToCash(id);
  }

  @override
  Future<List<PillEntity>> getAllPills(DateTime date) async {
    final list = await localDataSource.getLastPillFromCache();
    return list
        .where((element) =>
            element.timeToDrink.day == date.day &&
            element.timeToDrink.month == date.month &&
            element.timeToDrink.year == date.year)
        .toList();
  }

  @override
  updateStatus(String id, StatusEnum status) async {
    await localDataSource.updateToCash(id, status);
  }

  @override
  Future<List<PillEntity>> loadCachedPills() {
    // TODO: implement loadCachedPills
    throw UnimplementedError();
  }
}
