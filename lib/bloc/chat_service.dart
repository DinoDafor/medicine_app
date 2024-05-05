import 'package:medicine_app/utils/conversation.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatService {
  final List<Message> _messages = [];

  List<Message> getMessagesFromConversations(int chatId) {
    Chat chat = Conversation.conversations
        .firstWhere((element) => element.id == chatId);
    _messages.addAll(chat.messages);
    return _messages;
  }

  void addMessageToConversation(int chatId, Message message) {
    Conversation.conversations
        .firstWhere((element) => element.id == chatId)
        .messages
        .add(message);
  }

  void deleteMessagesFromLocalList() {
    _messages.clear();
  }
}
