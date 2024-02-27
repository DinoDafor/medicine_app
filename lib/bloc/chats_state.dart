part of 'chats_bloc.dart';

@immutable
abstract class ChatsState {}

class ChatsInitial extends ChatsState {}

class ChatsInitialLoadedSuccessfulState extends ChatsState {
  final List<Chat> chats;

  ChatsInitialLoadedSuccessfulState({required this.chats});
}
