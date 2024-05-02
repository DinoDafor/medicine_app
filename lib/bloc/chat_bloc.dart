import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_app/bloc/chat_service.dart';
import 'package:medicine_app/utils/token.dart';
import 'package:meta/meta.dart';

import '../models/message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService _chatService = ChatService();

  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<ChatSendMessageEvent>(_sendNewMessage);
    on<ChatLoadingEvent>(_getMessages);
    //todo пока пусть будет удаление из общего локального листа
    on<ChatLeavingEvent>(_deleteMessagesFromLocalList);
  }

  _sendNewMessage(ChatSendMessageEvent event, Emitter<ChatState> emit) {
    print("зашли в _sendNewMessage");
    _chatService.stompClient.send(
        destination: "/app/message",
        headers: {'Authorization': 'Bearer ${Token.token}'},
        body: jsonEncode(event.message));
    print("отправили");

    _chatService.addMessageToConversation(event.chatId, event.message);
    _chatService.deleteMessagesFromLocalList();

    emit(ChatLoadedSuccessfulState(
        chatId: event.chatId,
        messages: _chatService.getMessagesFromConversations(event.chatId),
        interlocutorId: event.interlocutorId));
  }

  _getMessages(ChatLoadingEvent event, Emitter<ChatState> emit) async {
    //todo: stomp
    _chatService.stompClient.activate();
    List<Message> messages =
        _chatService.getMessagesFromConversations(event.chatId);
    emit(ChatLoadedSuccessfulState(
        messages: messages,
        interlocutorId: event.interlocutorId,
        chatId: event.chatId));
  }

  _deleteMessagesFromLocalList(
      ChatLeavingEvent event, Emitter<ChatState> emitter) {
    _chatService.deleteMessagesFromLocalList();
  }
}
