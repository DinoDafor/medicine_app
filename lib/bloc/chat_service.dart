import 'dart:convert';

import 'package:medicine_app/utils/conversation.dart';
import 'package:medicine_app/utils/token.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatService {
  static const String destination = '/app/message';
  static const String destinationFrom = '/user/specific';
  late StompClient stompClient;
  final List<Message> _messages = [];

  ChatService() {
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://31.129.59.206/irecipe-chat',
        onConnect: onConnect,
        beforeConnect: () async {
          print('beforeConnect...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
        stompConnectHeaders: {'Authorization': 'Bearer ${Token.token}'},
        webSocketConnectHeaders: {'Authorization': 'Bearer ${Token.token}'},
      ),
    );

    stompClient.activate();
  }

  void onConnect(StompFrame frame) {
    print("Callback for when STOMP has successfully connected!");

    stompClient.subscribe(
      headers: {'Authorization': 'Bearer ${Token.token}'},
      destination: destinationFrom,
      callback: (frame) {
        print("зашли в коллбек подписки");
        print(frame.body);
        // List<dynamic>? result = json.decode(frame.body!);
        // print(result);
      },
    );
  }

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
