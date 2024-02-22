part of 'chats_bloc.dart';

@immutable
abstract class ChatsEvent {}

//Когда заходим на страницу чатов нужно послать ивент что мы зашли, для загрузки чатов с юзерами. Добавлять в initial?
class ChatsLoadingEvent extends ChatsEvent {}

//Когда нажимаем на сам чат для перехода
class ChatsClickEvent extends ChatsEvent {
  final int chatId;

  ChatsClickEvent({required this.chatId});
}
