import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_app/bloc/chat_service.dart';
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
    on<ChatReceiveMessageEvent>(_receiveMessageFromInterlocutor);
  }

  _sendNewMessage(ChatSendMessageEvent event, Emitter<ChatState> emit) {
    print("зашли в _sendNewMessage");
    _chatService.addMessageToConversation(event.chatId, event.message);
    _chatService.deleteMessagesFromLocalList();

    emit(ChatLoadedSuccessfulState(
        chatId: event.chatId,
        messages: _chatService.getMessagesFromConversations(event.chatId),
        interlocutorId: event.interlocutorId));
  }

  _getMessages(ChatLoadingEvent event, Emitter<ChatState> emit) async {
    //todo: stomp
    List<Message> messages =
        _chatService.getMessagesFromConversations(event.chatId);
    emit(ChatLoadedSuccessfulState(
        messages: messages,
        interlocutorId: event.interlocutorId,
        chatId: event.chatId));
  }

  _receiveMessageFromInterlocutor(
      ChatReceiveMessageEvent event, Emitter<ChatState> emit) {
    print("ПОЛУЧИЛИ И ОБРАБОТАЛИ ИВЕНТ ЧТО ПРИШЛО СООБЩЕНИЕ ОТ СОБЕСЕДНИКА");
    print("СООБЩЕНИЕ:" + event.message.toString());

    _chatService.addMessageToConversation(
        event.message.conversationId, event.message);
    _chatService.deleteMessagesFromLocalList();

    List<Message> messages =
        _chatService.getMessagesFromConversations(event.message.conversationId);
    emit(ChatLoadedSuccessfulState(
        chatId: event.message.conversationId,
        messages: messages,
        interlocutorId: event.message.senderId));
  }

  _deleteMessagesFromLocalList(
      ChatLeavingEvent event, Emitter<ChatState> emitter) {
    _chatService.deleteMessagesFromLocalList();
  }
}
