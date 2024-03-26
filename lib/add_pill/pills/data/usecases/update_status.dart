import 'package:equatable/equatable.dart';
import 'package:medicine_app/add_pill/pills/data/usecases/usecase.dart';

import '../../data/pill_repository.dart';
import '../model/enums/status_enum.dart';

class UpdateStatus extends UseCase<void, UpdateParams> {
  final PillRepository repository;

  UpdateStatus({required this.repository});

  @override
  Future<void> call(UpdateParams params) async {
    await repository.updateStatus(params.id, params.statusEnum);
  }
}

class UpdateParams extends Equatable {
  final String id;
  final StatusEnum statusEnum;

  UpdateParams(this.id, this.statusEnum);

  @override
  List<Object?> get props => [id, statusEnum];
}
