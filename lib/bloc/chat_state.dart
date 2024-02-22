part of 'chat_bloc.dart';

@immutable
abstract class ChatState {

}

class ChatInitial extends ChatState {}

//Нужно для показа прогрузки
class ChatLoadingState extends ChatState {}

//нужно для показа сообщений
class ChatLoadedSuccessfulState extends ChatState {
  final List<Message> messages;

  ChatLoadedSuccessfulState({required this.messages});
}
