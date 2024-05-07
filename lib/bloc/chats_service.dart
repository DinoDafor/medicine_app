import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medicine_app/utils/conversation.dart';

import '../models/chat_model.dart';
import '../utils/token.dart';
import '../utils/user.dart';

class UsersChatsService {
  final Dio _dio = Dio();

  Future<List<Chat>> getConversations() async {
    List<Chat> allChatsOfUser = [];

    Options options = Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
    var conversationsResponse = await _dio.get(
        "http://31.129.59.206/conversations/all/${User.id}",
        options: options);

    if (conversationsResponse.statusCode == 200) {
      List<Map<String, dynamic>> chatData =
          List<Map<String, dynamic>>.from(conversationsResponse.data);

      allChatsOfUser.addAll(chatData.map((chat) => Chat.fromJson(chat)));

      //СОРТИРОВКА CHATOV,
      //TODO: СОРТИРОВКА СООБЩЕНИЙ В ЧАТЕ
      allChatsOfUser.sort((chat1, chat2) {
        int timestamp1 = chat1.getLatestSendTime();
        int timestamp2 = chat2.getLatestSendTime();
        return timestamp1.compareTo(timestamp2);
      });
      allChatsOfUser = allChatsOfUser.reversed.toList();
      for (Chat chat in allChatsOfUser) {
        chat.sortMessagesBySendTime();
      }

      await Future.forEach(allChatsOfUser, (Chat chat) async {
        dynamic userResponse;
        if (User.id == chat.firstParticipantId) {
          userResponse = await _dio.get(
            "http://31.129.59.206/users/${chat.secondParticipantId}",
            options: options,
          );
          Conversation.idName[chat.secondParticipantId] =
              userResponse.data["name"];
        } else {
          userResponse = await _dio.get(
            "http://31.129.59.206/users/${chat.firstParticipantId}",
            options: options,
          );
          Conversation.idName[chat.firstParticipantId] =
              userResponse.data["name"];
        }
      });
      //todo: refactor
      Conversation.conversations.addAll(allChatsOfUser);
    }
    return allChatsOfUser;
  }
}
