part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatSendMessageEvent extends ChatEvent {
  final Message message;
  final int chatId;
  final int interlocutorId;
  final List<Message> messages;

  ChatSendMessageEvent(
      {required this.messages,
      required this.interlocutorId,
      required this.chatId,
      required this.message});
}

class ChatLoadingEvent extends ChatEvent {
  final int chatId;
  final int interlocutorId;

  ChatLoadingEvent({
    required this.chatId,
    required this.interlocutorId,
  });
}

class ChatLeavingEvent extends ChatEvent {}
