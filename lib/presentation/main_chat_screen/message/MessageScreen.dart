import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/app_export.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/appbar_leading_image.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/appbar_title.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/appbar_trailing_image.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/custom_app_bar.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/custom_floating_button.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/custom_text_form_field.dart';

class Message {
  String text;
  bool isSender;

  Message({required this.text, required this.isSender});
}

class OnehundredsevenScreen extends StatefulWidget {
  final String wssUrl;
  final String userName;

  OnehundredsevenScreen({Key? key, required this.wssUrl, required this.userName}) : super(key: key);

  @override
  _OnehundredsevenScreenState createState() => _OnehundredsevenScreenState();
}

class _OnehundredsevenScreenState extends State<OnehundredsevenScreen> {
  TextEditingController iconsmileComponentAdditionalIcController = TextEditingController();
  List<Message> messages = [];
  late StompClient stompClient;
  final ScrollController _scrollController = ScrollController();
  String jwtToken = '';
  int chatId = 0;
  String senderEmail = '';

  @override
  void initState() {
    super.initState();
    _loadCredentials();
    _initializeWebSocketConnection();
  }

  void _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      jwtToken = prefs.getString('jwtToken') ?? '';
      chatId = prefs.getInt('chatId') ?? 0;
      senderEmail = prefs.getString('senderEmail') ?? '';
    });
  }

  void _initializeWebSocketConnection() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('jwtToken') ?? '';

    if (jwtToken.isEmpty) {
      print('JWT Token is not found');
      return;
    }

    print('WebSocket URL: ${widget.wssUrl}');
    print('JWT Token: $jwtToken');

    stompClient = StompClient(
      config: StompConfig(
        url: widget.wssUrl,
        onConnect: _onConnect,
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(Duration(milliseconds: 200));
          print('connecting...');
        },
        stompConnectHeaders: {'Authorization': 'Bearer $jwtToken'},
        onWebSocketError: (dynamic error) => print(error.toString()),
        webSocketConnectHeaders: {'Authorization': 'Bearer $jwtToken'}, // Если требуется
      ),
    );

    stompClient.activate();
  }

  void _onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/user/topic/private-messages',
      callback: (frame) {
        if (frame.body != null) {
          setState(() {
            messages.add(Message(text: frame.body!, isSender: false));
          });
        }
      },
    );
  }

  @override
  void dispose() {
    stompClient.deactivate();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: appTheme.whiteA700,
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context) as PreferredSizeWidget?,
      body: SafeArea(
        child: Column(
          children: [
            _buildMessagesList(),
            _buildThemeLightComponentChat(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 52.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 24.h, top: 12.v, bottom: 15.v),
        onTap: () {
          stompClient.deactivate();
          Navigator.of(context).pop();
        },
      ),
      title: AppbarTitle(
        text: widget.userName,
        margin: EdgeInsets.only(left: 16.h),
      ),
      actions: _buildAppBarActions(),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      AppbarTrailingImage(
        imagePath: ImageConstant.imgSearch,
        margin: EdgeInsets.only(left: 24.h, top: 12.v, right: 15.h),
      ),
      AppbarTrailingImage(
        imagePath: ImageConstant.imgIconlyLightMore,
        margin: EdgeInsets.only(left: 20.h, top: 12.v, right: 39.h),
      ),
    ];
  }

  Widget _buildMessagesList() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return _buildMessageItem(
            context,
            messages[index].text,
            messages[index].isSender,
          );
        },
      ),
    );
  }

  Widget _buildMessageItem(BuildContext context, String message, bool isSender) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.v),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
          ),
          child: _buildMessageBubble(message, isSender),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String message, bool isSender) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.v),
        decoration: isSender
            ? AppDecoration.fillTealA.copyWith(borderRadius: BorderRadius.circular(10))
            : AppDecoration.fillGray.copyWith(borderRadius: BorderRadius.circular(10)),
        child: _buildMessageContent(message, isSender),
      ),
    );
  }

  Column _buildMessageContent(String message, bool isSender) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          message,
          softWrap: true,
          overflow: TextOverflow.visible,
          style: isSender
              ? theme.textTheme.titleMedium!.copyWith(height: 1.40)
              : CustomTextStyles.titleMediumGray900,
        ),
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text("12:00", style: CustomTextStyles.labelLargeGray300),
        ),
      ],
    );
  }

  Widget _buildThemeLightComponentChat(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 35.v),
      child: Row(
        children: [
          _buildMessageInputField(),
          SizedBox(width: 25),
          _buildSendMessageButton(),
        ],
      ),
    );
  }

  Expanded _buildMessageInputField() {
    return Expanded(
      child: CustomTextFormField(
        controller: iconsmileComponentAdditionalIcController,
        hintText: "Введите сообщение...",
        textInputAction: TextInputAction.done,
        prefix: _buildMessageInputPrefix(),
        prefixConstraints: BoxConstraints(maxHeight: 56.v),
        suffix: _buildMessageInputSuffix(),
        suffixConstraints: BoxConstraints(maxHeight: 56.v),
      ),
    );
  }

  Container _buildMessageInputPrefix() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.h, 18.v, 12.h, 18.v),
      child: CustomImageView(
        imagePath: ImageConstant.imgIconsmileComponentadditionalIcons,
        height: 20.adaptSize,
        width: 20.adaptSize,
      ),
    );
  }

  Container _buildMessageInputSuffix() {
    return Container(
      margin: EdgeInsets.fromLTRB(28.h, 18.v, 30.h, 18.v),
      child: CustomImageView(
        imagePath: ImageConstant.imgIconpaperclipComponentadditionalIcons,
        height: 20.adaptSize,
        width: 20.adaptSize,
      ),
    );
  }

  GestureDetector _buildSendMessageButton() {
    return GestureDetector(
      onTap: _sendMessage,
      child: CustomFloatingButton(
        height: 52,
        width: 52,
        backgroundColor: appTheme.tealA700,
        child: CustomImageView(
          imagePath: ImageConstant.imgSend,
          height: 26.0.v,
          width: 26.0.h,
        ),
      ),
    );
  }

  void _sendMessage() {
    if (iconsmileComponentAdditionalIcController.text.isNotEmpty) {
      final message = iconsmileComponentAdditionalIcController.text;
      _sendStompMessage(message);
      setState(() {
        messages.add(Message(text: message, isSender: true));
      });
      iconsmileComponentAdditionalIcController.clear();
      _scrollToBottom();
    }
  }

  void _sendStompMessage(String message) {
    stompClient.send(
      destination: '/app/private-chat',
      body: '{"senderSubject": "$senderEmail", "chatId": $chatId, "messageText": "$message"}',
      headers: {},
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      });
    }
  }
}
