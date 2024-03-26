import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_entity.dart';
import 'package:medicine_app/add_pill/pills/data/usecases/add_pill.dart';
import 'package:medicine_app/add_pill/pills/data/usecases/delete_pill.dart';
import 'package:medicine_app/add_pill/pills/data/usecases/get_all_pills.dart';
import 'package:medicine_app/add_pill/pills/data/usecases/update_status.dart';

import '../model/enums/status_enum.dart';

part 'pill_event.dart';
part 'pill_state.dart';

class PillBloc extends Bloc<PillBlocEvent, PillBlocState> {
  PillBloc(
      {required this.getAllPills,
      required this.deletePill,
      required this.addPill,
      required this.updateStatus})
      : super(PillInitial()) {
    on<LoadPillBloc>(_load);
    on<DeletePillBloc>(_delete);
    on<AddPillBloc>(_add);
    on<UpdatePillBloc>(_update);
  }
  final AddPill addPill;
  final DeletePill deletePill;
  final GetAllPills getAllPills;
  final UpdateStatus updateStatus;

  void _update(UpdatePillBloc event, Emitter<PillBlocState> emit) async {
    if (state is! PillLoaded) {
      emit(PillLoading());
    }
    await updateStatus.call(UpdateParams(event.pillId, event.status));
  }

  void _add(AddPillBloc event, Emitter<PillBlocState> emit) async {
    if (state is! PillLoaded) {
      emit(PillLoading());
    }
    await addPill.call(AddParams(event.pill));
  }

  void _delete(DeletePillBloc event, Emitter<PillBlocState> emit) async {
    if (state is! PillLoaded) {
      emit(PillLoading());
    }
    await deletePill.call(DeleteParams(event.pillId));
  }

  void _load(
    LoadPillBloc event,
    Emitter<PillBlocState> emit,
  ) async {
    if (state is! PillLoaded) {
      emit(PillLoading());
    }
    final pillList = await getAllPills.call(GetParams(event.date));
    emit(PillLoaded(pillList: pillList));
  }
}
