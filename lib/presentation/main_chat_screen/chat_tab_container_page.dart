import 'package:flutter/material.dart';
import 'package:medicine_app/core/app_export.dart';
import 'package:medicine_app/presentation/main_chat_screen/chat_page.dart';
import 'package:medicine_app/widgets/app_bar/appbar_title.dart';
import 'package:medicine_app/widgets/app_bar/appbar_trailing_image.dart';
import 'package:medicine_app/widgets/app_bar/custom_app_bar.dart';
import 'package:medicine_app/presentation/testchat/chat_screen.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/MessageScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class ThirtyfiveTabContainerPage extends StatefulWidget {
  const ThirtyfiveTabContainerPage({Key? key}) : super(key: key);

  @override
  ThirtyfiveTabContainerPageState createState() => ThirtyfiveTabContainerPageState();
}

class ThirtyfiveTabContainerPageState extends State<ThirtyfiveTabContainerPage> with TickerProviderStateMixin {
  late TabController tabviewController;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: _buildAppBar(context),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            SizedBox(height: 21.v),
            _buildTabview(context),
            SizedBox(
              height: 654.v,
              child: TabBarView(
                controller: tabviewController,
                children: [
                  ThirtyfivePage(),
                  ThirtyfivePage(),
                  ThirtyfivePage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "Чаты",
        margin: EdgeInsets.only(left: 24.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgIconlyLightSearch,
          margin: EdgeInsets.only(
            left: 24.h,
            top: 13.v,
            right: 14.h,
          ),
        ),
        AppbarTrailingImage(
            imagePath: ImageConstant.imgIconlyLightMore,
            margin: EdgeInsets.only(
              left: 20.h,
              top: 13.v,
              right: 38.h,
            ),
            onTap: () {
              _showCreateChatDialog(context);
            }
        ),
      ],
    );
  }

  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 39.v,
      width: 380.h,
      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: appTheme.tealA700,
        labelStyle: TextStyle(
          fontSize: 18.fSize,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: appTheme.gray500,
        unselectedLabelStyle: TextStyle(
          fontSize: 18.fSize,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        ),
        indicatorColor: appTheme.tealA700,
        tabs: [
          Tab(
            child: Text("Сообщение"),
          ),
          Tab(
            child: Text("Звонки"),
          ),
          Tab(
            child: Text("Видеозвонки"),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateChatDialog(BuildContext context) async {
    TextEditingController emailController = TextEditingController();
    AuthenticationService authService = AuthenticationService();
    UserService userService;
    ChatService chatService;

    print('Открытие диалога создания чата');
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Создать новый чат'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Введите email пользователя',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Создать'),
              onPressed: () async {
                print('Нажата кнопка Создать');
                try {
                  print('Попытка аутентификации пользователя...');
                  var authResult = await authService.authenticateUser();
                  print('Данные аутентификации: ${authResult.toString()}');
                  if (authResult.isNotEmpty) {
                    print('Аутентификация прошла успешно.');

                    userService = UserService(authResult['jwtToken']);
                    chatService = ChatService(authResult['jwtToken']);

                    print('Поиск пользователя по email: ${emailController.text}');
                    var foundUser = await userService.findUserByEmail(emailController.text);
                    print('Пользователь найден: ${foundUser.toString()}');

                    print('Создание чата...');
                    int chatId = await chatService.createChat();
                    print('Чат создан: ID $chatId');

                    print('Добавление пользователей в чат...');
                    await chatService.addUsersToChat(chatId, int.parse(authResult['id']), int.parse(foundUser['id']!));
                    print('Пользователи добавлены в чат');

                    // Закрытие диалогового окна после завершения всех асинхронных операций
                    Navigator.of(context).pop();

                    if (mounted) {
                      print('Переход на страницу чата...');
                      String wsUrl = ChatWebSocketLinkGenerator().generateWebSocketLink(authResult['jwtToken'], chatId);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OnehundredsevenScreen(
                          wssUrl: wsUrl,
                          userName: "${foundUser['firstName']} ${foundUser['lastName']}",
                        ),
                      ));
                    }
                  } else {
                    print('Ошибка аутентификации: данные не получены.');
                  }
                } catch (e) {
                  if (mounted) {
                    print('Ошибка аутентификации: ${e.toString()}');
                    Navigator.of(context).pop(); // Закрыть диалог в случае ошибки
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      SnackBar(
                        content: Text('Ошибка: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

}

class AuthenticationService {
  Future<Map<String, dynamic>> authenticateUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('userEmail') ?? '';
    String password = prefs.getString('userPassword') ?? '';

    var response = await _attemptAuthentication(
      'http://ezhidze.su:8080/medApp/doctors/authentication',
      email,
      password,
    );

    if (response.statusCode != 200) {
      response = await _attemptAuthentication(
        'http://ezhidze.su:8080/medApp/patients/authentication',
        email,
        password,
      );
    }

    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Логирование полученного JWT токена
      print("Received jwtToken: ${data['token:']}");

      if (data['token:'] != null) {
        await prefs.setString('jwtToken', data['token:']);
        await prefs.setString('senderEmail', email);
        print("JWT token and sender email saved in SharedPreferences");
      } else {
        print("JWT token is null, not saving to SharedPreferences");
      }

      return {
        'id': data['id'].toString(),
        'jwtToken': data['token:']
      };
    } else {
      throw Exception('Authentication failed');
    }
  }

  Future<http.Response> _attemptAuthentication(String url, String email, String password) {
    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }
}



class UserService {
  final String jwtToken;

  UserService(this.jwtToken);

  Future<Map<String, String>> findUserByEmail(String email) async {
    var response = await http.get(
      Uri.parse('http://ezhidze.su:8080/medApp/doctors'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> doctors = json.decode(response.body);
      var foundDoctor = doctors.firstWhere(
            (doctor) => doctor['email'] == email,
        orElse: () => null,
      );
      if (foundDoctor != null) {
        return {
          'id': foundDoctor['id'].toString(),
          'firstName': foundDoctor['firstName'],
          'lastName': foundDoctor['lastName'],
        };
      }
    }

    response = await http.get(
      Uri.parse('http://ezhidze.su:8080/medApp/patients'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> patients = json.decode(response.body);
      var foundPatient = patients.firstWhere(
            (patient) => patient['email'] == email,
        orElse: () => null,
      );
      if (foundPatient != null) {
        return {
          'id': foundPatient['id'].toString(),
          'firstName': foundPatient['firstName'],
          'lastName': foundPatient['lastName'],
        };
      }
    }

    throw Exception('Такого пользователя не существует');
  }
}

class ChatService {
  final String jwtToken;

  ChatService(this.jwtToken);

  Future<int> createChat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('jwtToken') ?? '';

    if (jwtToken.isEmpty) {
      throw Exception('JWT Token is not found.');
    }

    var response = await http.post(
      Uri.parse('http://ezhidze.su:8080/addChat'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['id'] != null) {
        await prefs.setInt('chatId', data['id']);
        return data['id'];
      } else {
        throw Exception('ID чата не найден в ответе сервера');
      }
    } else {
      throw Exception('Ошибка при создании чата: ${response.statusCode}');
    }
  }

  Future<http.Response> addUserToChat(int chatId, int userId, String role) async {
    var response = await http.put(
      Uri.parse('http://ezhidze.su:8080/joinUser?chatId=$chatId&userId=$userId&role=$role'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );
    return response;
  }


  Future<void> addUsersToChat(int chatId, int firstUserId, int secondUserId) async {
    // Добавление первого пользователя
    var firstUserAdded = false;
    try {
      var response = await addUserToChat(chatId, firstUserId, 'DOCTOR');
      if (response.statusCode == 200) {
        firstUserAdded = true;
        print('Первый пользователь с ID $firstUserId успешно добавлен как DOCTOR');
      }
    } catch (e) {
      print('Ошибка при добавлении первого пользователя с ID $firstUserId с ролью DOCTOR: $e');
    }

    if (!firstUserAdded) {
      try {
        var response = await addUserToChat(chatId, firstUserId, 'PATIENT');
        if (response.statusCode == 200) {
          firstUserAdded = true;
          print('Первый пользователь с ID $firstUserId успешно добавлен как PATIENT');
        }
      } catch (e) {
        print('Ошибка при добавлении первого пользователя с ID $firstUserId с ролью PATIENT: $e');
      }
    }

    if (!firstUserAdded) throw Exception('Не удалось добавить первого пользователя в чат');

    // Добавление второго пользователя
    var secondUserAdded = false;
    try {
      var response = await addUserToChat(chatId, secondUserId, 'DOCTOR');
      if (response.statusCode == 200) {
        secondUserAdded = true;
        print('Второй пользователь с ID $secondUserId успешно добавлен как DOCTOR');
      }
    } catch (e) {
      print('Ошибка при добавлении второго пользователя с ID $secondUserId с ролью DOCTOR: $e');
    }

    if (!secondUserAdded) {
      try {
        var response = await addUserToChat(chatId, secondUserId, 'PATIENT');
        if (response.statusCode == 200) {
          secondUserAdded = true;
          print('Второй пользователь с ID $secondUserId успешно добавлен как PATIENT');
        }
      } catch (e) {
        print('Ошибка при добавлении второго пользователя с ID $secondUserId с ролью PATIENT: $e');
      }
    }

    if (!secondUserAdded) throw Exception('Не удалось добавить второго пользователя в чат');
  }
}

class ChatWebSocketLinkGenerator {
  String generateWebSocketLink(String jwtToken, int chatId) {
    final baseUrl = 'ws://ezhidze.su:8080/chat';
    return baseUrl;
  }
}

