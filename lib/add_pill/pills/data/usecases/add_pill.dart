import 'package:equatable/equatable.dart';
import 'package:medicine_app/add_pill/pills/data/pill_repository.dart';

import 'package:medicine_app/add_pill/pills/data/usecases/usecase.dart';

import '../../data/model/pill_entity.dart';

class AddPill extends UseCase<void, AddParams> {
  final PillRepository repository;

  AddPill({required this.repository});

  @override
  Future<void> call(params) async {
    await repository.addPill(params.pill);
  }
}

class AddParams extends Equatable {
  PillEntity pill;

  AddParams(this.pill);

  @override
  List<Object?> get props => [pill];
}
