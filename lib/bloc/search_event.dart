part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchSendEmailOfDoctorEvent extends SearchEvent {
  final String email;

  SearchSendEmailOfDoctorEvent({required this.email});
}

class SearchCreateConversationWithDoctorEvent extends SearchEvent {
  final int firstParticipantId;
  final int secondParticipantId;
  final BuildContext context;
  final String doctorName;

  SearchCreateConversationWithDoctorEvent(
      {required this.firstParticipantId,
      required this.secondParticipantId,
      required this.context,
      required this.doctorName});
}
