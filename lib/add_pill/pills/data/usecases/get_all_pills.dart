import 'package:equatable/equatable.dart';
import 'package:medicine_app/add_pill/pills/data/pill_repository.dart';

import 'package:medicine_app/add_pill/pills/data/usecases/usecase.dart';

import '../../data/model/pill_entity.dart';

class GetAllPills extends UseCase<List<PillEntity>, GetParams> {
  final PillRepository repository;

  GetAllPills({required this.repository});

  @override
  Future<List<PillEntity>> call(GetParams params) async {
    return await repository.getAllPills(params.date);
  }
}

class GetParams extends Equatable {
  final DateTime date;

  GetParams(this.date);

  @override
  List<Object?> get props => [date];
}
