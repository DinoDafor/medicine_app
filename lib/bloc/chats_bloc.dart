import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:medicine_app/bloc/chats_service.dart';
import 'package:meta/meta.dart';

import '../models/chat_model.dart';

part 'chats_event.dart';

part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final UsersChatsService _chatService = UsersChatsService();

  ChatsBloc() : super(ChatsInitial()) {
    on<ChatsEvent>((event, emit) {});
    on<ChatsLoadingEvent>(_getChats);
    on<ChatsClickEvent>(_navigateToChat);
  }

  _getChats(ChatsLoadingEvent event, Emitter<ChatsState> emit) async {
    List<Chat> chatsList = await _chatService.getUsersChats();

    emit(ChatsInitialLoadedSuccessfulState(chats: chatsList));
  }

  _navigateToChat(ChatsClickEvent event, Emitter<ChatsState> emit) {
    emit(ChatsClickSuccessfulState());
  }
}
