part of 'pill_bloc.dart';

abstract class PillBlocState extends Equatable {}

class PillInitial extends PillBlocState {
  @override
  List<Object?> get props => [];
}

class PillLoading extends PillBlocState {
  @override
  List<Object?> get props => [];
}

class PillLoaded extends PillBlocState {
  PillLoaded({
    required this.pillList,
  })
  {
    pillList.sort((pill1, pill2) =>pill1.timeToDrink.compareTo(pill2.timeToDrink));
  }

 

  final List<PillEntity> pillList;

  @override
  List<Object?> get props => [pillList];
}

class PillLoadingFailure extends PillBlocState {
  PillLoadingFailure({
    required this.exception,
  });
  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
