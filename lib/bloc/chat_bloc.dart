import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:medicine_app/bloc/chat_service.dart';
import 'package:meta/meta.dart';

import '../models/message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService _chatService = ChatService();

  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {
    });
    on<ChatNewMessageEvent>(_showNewMessage);
    on<ChatLoadingEvent>(_getMessages);
    //todo пока пусть будет удаление из общего локального листа
    on<ChatLeavingEvent>(_deleteMessagesFromLocalList);
  }
  _showNewMessage(ChatNewMessageEvent event, Emitter<ChatState> emit){
    // _chatService
  }
  _getMessages(ChatLoadingEvent event, Emitter<ChatState> emit) async{
    List<Message> messages = await _chatService.getMessages(event.chatId);
    emit(ChatLoadedSuccessfulState(messages: messages));
  }
  _deleteMessagesFromLocalList(ChatLeavingEvent event, Emitter<ChatState>emitter) {
    _chatService.deleteMessagesFromLocalList();
    // event.messages.clear();
  }

}
