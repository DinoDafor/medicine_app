import 'package:bloc/bloc.dart';
import 'package:medicine_app/bloc/chats_service.dart';
import 'package:medicine_app/utils/conversation.dart';
import 'package:meta/meta.dart';

import '../models/chat_model.dart';

part 'chats_event.dart';

part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final UsersChatsService _chatService = UsersChatsService();

  ChatsBloc() : super(ChatsInitial()) {
    on<ChatsEvent>((event, emit) {});
    on<ChatsLoadingEvent>(_getChats);
    on<ChatsNewMessageEvent>(_moveChatToTop);
  }

  _getChats(ChatsLoadingEvent event, Emitter<ChatsState> emit) async {
    List<Chat> chatsList = await _chatService.getConversations();

    emit(ChatsInitialLoadedSuccessfulState(chats: chatsList));
  }

  _moveChatToTop(ChatsNewMessageEvent event, Emitter<ChatsState> emit)  {
    _chatService.moveChatToTop(event.chatId);
    emit(ChatsInitialLoadedSuccessfulState(chats: Conversation.conversations));
  }
}
