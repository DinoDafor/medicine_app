import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/app_export.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/appbar_leading_image.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/appbar_title.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/appbar_trailing_image.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/custom_app_bar.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/custom_floating_button.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/custom_text_form_field.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:stomp_dart_client/stomp_config.dart';


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
  late IOWebSocketChannel channel;
  final ScrollController _scrollController = ScrollController();
  String lastSentMessage = "";

  @override
  void initState() {
    super.initState();
    print("Connecting to WebSocket URL: ${widget.wssUrl}"); // Добавлено логирование URL
    channel = IOWebSocketChannel.connect(widget.wssUrl);

    channel.stream.listen((data) {
      setState(() {
        if (data != lastSentMessage) {
          messages.add(Message(text: data, isSender: false));
          _scrollToBottom();
        }
      });
    }, onError: (error) {
      print("WebSocket Error: $error"); // Добавлено логирование ошибок
    });
  }


  @override
  void dispose() {
    channel.sink.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: appTheme.whiteA700,
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageItem(
                      context, messages[index].text, messages[index].isSender);
                },
              ),
            ),
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
              Navigator.of(context).pop();
            }),
        title: AppbarTitle(
            text: widget.userName, margin: EdgeInsets.only(left: 16.h)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgSearch,
              margin: EdgeInsets.only(left: 24.h, top: 12.v, right: 15.h)),
          AppbarTrailingImage(
              imagePath: ImageConstant.imgIconlyLightMore,
              margin: EdgeInsets.only(left: 20.h, top: 12.v, right: 39.h))
        ]);
  }

  Widget _buildMessageItem(BuildContext context, String message,
      bool isSender) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.v),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery
                .of(context)
                .size
                .width * 0.6,
          ),
          child: IntrinsicWidth(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.v),
              decoration: isSender
                  ? AppDecoration.fillTealA.copyWith(
                  borderRadius: BorderRadius.circular(10))
                  : AppDecoration.fillGray.copyWith(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
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
                    child: Text(
                        "12:00", style: CustomTextStyles.labelLargeGray300),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeLightComponentChat(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 35.v),
      child: Row(children: [
        Expanded(
          child: CustomTextFormField(
              controller: iconsmileComponentAdditionalIcController,
              hintText: "Введите сообщение...",
              textInputAction: TextInputAction.done,
              prefix: Container(
                  margin: EdgeInsets.fromLTRB(20.h, 18.v, 12.h, 18.v),
                  child: CustomImageView(
                      imagePath: ImageConstant
                          .imgIconsmileComponentadditionalIcons,
                      height: 20.adaptSize,
                      width: 20.adaptSize)),
              prefixConstraints: BoxConstraints(maxHeight: 56.v),
              suffix: Container(
                  margin: EdgeInsets.fromLTRB(28.h, 18.v, 30.h, 18.v),
                  child: CustomImageView(
                      imagePath: ImageConstant
                          .imgIconpaperclipComponentadditionalIcons,
                      height: 20.adaptSize,
                      width: 20.adaptSize)),
              suffixConstraints: BoxConstraints(maxHeight: 56.v)),
        ),
        SizedBox(width: 25),
        GestureDetector(
          onTap: _sendMessage,
          child: CustomFloatingButton(
              height: 52,
              width: 52,
              backgroundColor: appTheme.tealA700,
              child: CustomImageView(
                  imagePath: ImageConstant.imgSend,
                  height: 26.0.v,
                  width: 26.0.h)),
        ),
      ]),
    );
  }

  void _sendMessage() {
    if (iconsmileComponentAdditionalIcController.text.isNotEmpty) {
      lastSentMessage = iconsmileComponentAdditionalIcController.text;
      channel.sink.add(lastSentMessage);
      setState(() {
        messages.add(Message(text: lastSentMessage, isSender: true));
        iconsmileComponentAdditionalIcController.clear();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
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
