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
    var conversationsResponse = await _dio
        .get("http://10.0.2.2:8080/conversations/${User.id}", options: options);

    if (conversationsResponse.statusCode == 200) {
      List<Map<String, dynamic>> chatData =
          List<Map<String, dynamic>>.from(conversationsResponse.data);
      allChatsOfUser.addAll(chatData.map((chat) => Chat.fromJson(chat)));

      //TODO: надо как-то правильно сортировать чаты здесь
      allChatsOfUser.sort();
      //TODO: ещё надо делать сортировку сообщений для каждого Chat))
      print("сколько чатов: ");
      print(allChatsOfUser.length);
      //TODO: Забирает ВСЕ с сервера, надо по частям сделать
      await Future.forEach(allChatsOfUser, (Chat chat) async {
        dynamic userResponse;
        if (User.id == chat.firstParticipantId) {
          userResponse = await _dio.get(
            "http://10.0.2.2:8080/users/${chat.secondParticipantId}",
            options: options,
          );
          Conversation.idName[chat.secondParticipantId] =
              userResponse.data["name"];
        } else {
          userResponse = await _dio.get(
            "http://10.0.2.2:8080/users/${chat.firstParticipantId}",
            options: options,
          );
          Conversation.idName[chat.firstParticipantId] =
              userResponse.data["name"];
        }
      });
      //todo: refactor
      print("После добавления в мапу ");
      print(Conversation.idName);
      Conversation.conversations.addAll(allChatsOfUser);
    }
    return allChatsOfUser;
  }
}
