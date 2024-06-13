part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {
  final bool isLoading;

  SearchLoadingState({required this.isLoading});
}

class SearchFindDoctorsSuccessfullyState extends SearchState {
  final Doctor doctor;

  SearchFindDoctorsSuccessfullyState({required this.doctor});
}

class SearchDoctorNotFoundState extends SearchState {}
