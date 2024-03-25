import 'package:medicine_app/utils/conversation.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatService {
  final List<Message> _messages = [];
  //todo для эндпоинта получения сообщений
  // Future<List<Message>> getMessages(int chatId) async {
  //   //,
  //   //         options: options
  //   // Options options = Options(
  //   //     headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
  //   var response =
  //   await _dio.get(_URL, queryParameters: {"chatId": chatId});
  //   if (response.statusCode == 200) {
  //     List<Map<String, dynamic>> chatData =
  //         List<Map<String, dynamic>>.from(response.data);
  //     _messages.addAll(chatData.map((message) => Message.fromJson(message)));
  //     return _messages;
  //     //
  //   }
  //   //todo пустой, сделать обработку
  //   return _messages;
  // }

  List<Message> getMessagesFromConversations(int chatId) {
    Chat chat = Conversation.conversations
        .firstWhere((element) => element.id == chatId);
    _messages.addAll(chat.messages);
    return _messages;
  }

  deleteMessagesFromLocalList() {
    _messages.clear();
  }
}
