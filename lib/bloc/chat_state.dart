part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

//Нужно для показа прогрузки
class   ChatLoadingState extends ChatState {}

//нужно для показа сообщений
class ChatLoadedSuccessfulState extends ChatState {
  final List<Message> messages;
  final int chatId;
  final int interlocutorId;

  ChatLoadedSuccessfulState(
      {required this.chatId,
      required this.messages,
      required this.interlocutorId});
}

class ChatLeavedState extends ChatState {
  final List<Message> messages;

  ChatLeavedState({required this.messages});
}
