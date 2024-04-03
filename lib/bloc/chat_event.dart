part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatSendMessageEvent extends ChatEvent {
  final Message message;

  ChatSendMessageEvent({required this.message});
}

class ChatLoadingEvent extends ChatEvent {
  final int chatId;

  ChatLoadingEvent({required this.chatId});
}

class ChatLeavingEvent extends ChatEvent {}
