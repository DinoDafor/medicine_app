import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medicine_app/screens/registration_screen.dart';
import 'package:medicine_app/screens/users_chat.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Авторизация",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              //todo доделать валидацию по почте
              validator: (value) {
                if (value != null) {
                  if (EmailValidator.validate(value)) {
                    return null;
                  } else {
                    return "Email is not valide";
                  }
                }
              },
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email),
                hintText: "Email",
              ),
            ),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                //todo добавить валидацию пароля, проверку регистров, длины и так далее
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.shield),
                hintText: "Пароль",
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //запрос на сервер с формой
                  var response = await http
                      .post(Uri.parse('https://httpbin.org/post'), body: {
                    "username": _emailController.text.trim(),
                    "password": _passwordController.text.trim(),
                  });
                  print("response: ${response.body}");
                  if (response.statusCode == 200) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen()),
                    );
                  }
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
              ),
              child: Text("Авторизироваться"),
            ),
            Row(
              children: [
                Text(
                  "Вы у нас впервые?",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      //todo добавить переход на страницы регистрации
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationScreen()),
                      );
                    },
                    child: Text("Зарегистрируйтесь"))
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
