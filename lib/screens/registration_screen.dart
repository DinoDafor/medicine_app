import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medicine_app/screens/users_chat.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              "Регистрация",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email),
                hintText: "Email ID",
              ),
            ),
            TextFormField(

              decoration: InputDecoration(
                prefixIcon: Icon(Icons.shield),
                hintText: "Ваше имя",
              ),
              obscureText: true,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Номер телефона",
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Пароль",
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Повторите пароль",
              ),
            ),
            ElevatedButton(
              onPressed: (){

              },
              // onPressed: () async {
              //   if (_formKey.currentState!.validate()) {
              //     //запрос на сервер с формой
              //     var response = await http
              //         .post(Uri.parse('https://httpbin.org/post'), body: {
              //       "username": _emailController.text.trim(),
              //       "password": _passwordController.text.trim(),
              //     });
              //     print("response: ${response.body}");
              //     if (response.statusCode == 200) {
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(builder: (context) => const ChatScreen()),
              //       // );
              //     }
              //   }
              // },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
              ),
              child: Text("Зарегистрироваться"),
            ),
            Row(
              children: [
                Text(
                  "Вы уже зарегистрировались?",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                TextButton(onPressed: () {
                  //todo добавить переход на страницы авторизации
                  Navigator.pop(
                    context,
                  );
                }, child: Text("Войти"))
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
