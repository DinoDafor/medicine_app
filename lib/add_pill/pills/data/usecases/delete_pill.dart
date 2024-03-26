import 'package:equatable/equatable.dart';
import 'package:medicine_app/add_pill/pills/data/pill_repository.dart';
import 'package:medicine_app/add_pill/pills/data/usecases/usecase.dart';

class DeletePill extends UseCase<void, DeleteParams> {
  final PillRepository repository;

  DeletePill({required this.repository});

  @override
  Future<void> call(DeleteParams params) async {
    await repository.deletePill(params.id);
  }
}

class DeleteParams extends Equatable {
  final String id;

  DeleteParams(this.id);

  @override
  List<Object?> get props => [id];
}
