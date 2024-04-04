import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medicine_app/utils/conversation.dart';

import '../models/chat_model.dart';
import '../utils/token.dart';
import '../utils/user.dart';

class UsersChatsService {
  final Dio _dio = Dio();

  Future<List<Chat>> getConversations() async {
    List<Chat> chats = [];

    Options options = Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
    var conversationsResponse = await _dio
        .get("http://10.0.2.2:8080/conversations/${User.id}", options: options);

    if (conversationsResponse.statusCode == 200) {
      List<Map<String, dynamic>> chatData =
          List<Map<String, dynamic>>.from(conversationsResponse.data);
      chats.addAll(chatData.map((chat) => Chat.fromJson(chat)));
      //TODO: надо как-то правильно сортировать чаты здесь
      chats.sort();
      //TODO: ещё надо делать сортировку сообщений для каждого Chat))

      //TODO: Забирает ВСЕ с сервера, надо по частям сделать
      await Future.forEach(chats, (Chat chat) async {
        var userResponse = await _dio.get(
          "http://10.0.2.2:8080/users/${chat.firstParticipantId}",
          options: options,
        );
        Conversation.idName[chat.firstParticipantId] =
            userResponse.data["name"];
      });
      //todo: refactor

      Conversation.conversations.addAll(chats);
    }
    return chats;
  }
}
