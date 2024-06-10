part of 'pill_bloc.dart';

abstract class PillBlocEvent extends Equatable {}

class LoadPillBloc extends PillBlocEvent {
  LoadPillBloc({required this.date});

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class DeletePillBloc extends PillBlocEvent {
  final String pillId;

  DeletePillBloc({required this.pillId});

  @override
  List<Object?> get props => [pillId];
}

class PillReminderEvent extends PillBlocEvent {
  final PillModel pill;

  PillReminderEvent({required this.pill});

  @override
  List<Object?> get props => [pill];
}

class AddPillBloc extends PillBlocEvent {
  final PillEntity pill;

  AddPillBloc({required this.pill});

  @override
  List<Object?> get props => [pill];
}

class UpdatePillBloc extends PillBlocEvent {
  final String pillId;
  final StatusEnum status;

  UpdatePillBloc({required this.pillId, required this.status});

  @override
  List<Object?> get props => [pillId, status];
}
