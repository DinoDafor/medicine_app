import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_app/bloc/search_service.dart';
import 'package:medicine_app/models/chat_model.dart';
import 'package:medicine_app/models/doctor_model.dart';
import 'package:medicine_app/utils/conversation.dart';
import 'package:meta/meta.dart';

import '../utils/user.dart';
import 'chat_bloc.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService searchService = SearchService();

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});

    on<SearchSendEmailOfDoctorEvent>(_onSend);
    on<SearchCreateConversationWithDoctorEvent>(
        _onCreateConversationWithDoctor);
  }

  _onSend(SearchSendEmailOfDoctorEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState(isLoading: true));

    Doctor? doctor = await searchService.getDoctorsByEmail(event.email);
    emit(SearchLoadingState(isLoading: false));
    if (doctor == null) {
      emit(SearchDoctorNotFoundState());
    } else {
      emit(SearchFindDoctorsSuccessfullyState(doctor: doctor));
    }
  }

  _onCreateConversationWithDoctor(SearchCreateConversationWithDoctorEvent event,
      Emitter<SearchState> emit) async {
    var response = await searchService.createNewConversation(
        event.firstParticipantId, event.secondParticipantId);

    if (response.statusCode == 200) {
      User.id == event.firstParticipantId
          ? Conversation.idName[event.secondParticipantId] = event.doctorName
          : Conversation.idName[event.firstParticipantId] = event.doctorName;
      Conversation.conversations.add(Chat(
          id: response.data["id"],
          firstParticipantId: event.firstParticipantId,
          secondParticipantId: event.secondParticipantId,
          messages: []));
      //todo: заменить на отправку ивента
      event.context.go("/chats/chat", extra: response.data["id"]);

      BlocProvider.of<ChatBloc>(event.context).add(ChatLoadingEvent(
          chatId: response.data["id"],
          interlocutorId: User.id == event.firstParticipantId
              ? event.secondParticipantId
              : event.firstParticipantId));
    } else if (response.statusCode == 400) {
      //todo мы всё равно должны переходить в чат, который у нас уже лежит
      print("404 bad request");
      print(
          "Беседа уже создана для ${event.firstParticipantId} и ${event.secondParticipantId}");
    }
  }
}
//ответ:
// {
// "id": 6702,
// "firstParticipantId": 506,
// "secondParticipantId": 402,
// "messages": null
// }
