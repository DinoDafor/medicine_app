part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatNewMessageEvent  extends ChatEvent {

}
class ChatLoadingEvent  extends ChatEvent {
 final int chatId;

  ChatLoadingEvent({required this.chatId});
}

class ChatLeavingEvent  extends ChatEvent {

}
