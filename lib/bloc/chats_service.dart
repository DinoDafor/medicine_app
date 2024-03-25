import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medicine_app/utils/conversation.dart';

import '../models/chat_model.dart';
import '../utils/token.dart';

class UsersChatsService {
  final Dio _dio = Dio();

  Future<List<Chat>> getConversations() async {
    List<Chat> chats = [];

    Options options = Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
    var response = await _dio.get("http://10.0.2.2:8080/conversations/1",
        options: options);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> chatData =
          List<Map<String, dynamic>>.from(response.data);
      chats.addAll(chatData.map((chat) => Chat.fromJson(chat)));
      Conversation.conversations.addAll(chats);
    }
    return chats;
  }
}
