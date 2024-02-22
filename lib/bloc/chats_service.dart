import 'dart:io';

import 'package:dio/dio.dart';

import '../models/chat_model.dart';

class UsersChatsService {
  final Dio _dio = Dio();
  final String _URL = 'http://192.168.0.10:3000/chatsCards';

  //todo async await statuscode exepstions try catch
  Future<List<Chat>> getUsersChats() async {
    List<Chat> chats = [];
    // Options options = Options(
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
    //, options: options
    var response = await _dio
        .get(_URL);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> chatData =
      List<Map<String, dynamic>>.from(response.data);
      chats.addAll(chatData.map((chat) => Chat.fromJson(chat)));
    }
    return chats;
  }
}