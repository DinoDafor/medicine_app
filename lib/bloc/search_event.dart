part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchSendEmailOfDoctorEvent extends SearchEvent {
  final String email;

  SearchSendEmailOfDoctorEvent({required this.email});
}
