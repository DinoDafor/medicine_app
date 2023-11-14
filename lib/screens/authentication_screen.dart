import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

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
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Авторизация",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
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
                          prefixIcon: Container(
                            child: Icon(Icons.alternate_email),
                            margin: EdgeInsets.only(right: 10),
                          ),
                          prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                          hintText: "Email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          //todo добавить валидацию пароля, проверку регистров, длины и так далее
                          if (value == null || value.isEmpty) {
                            return 'Password can not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIconConstraints: const BoxConstraints(
                            minHeight: 0,
                            minWidth: 0,
                          ),
                          prefixIcon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Icon(Icons.shield)),
                          suffixIcon: const Text(
                            "Забыли пароль?",
                            style: TextStyle(
                                color: Color(0xFF0EBE7E),
                                fontWeight: FontWeight.bold),
                          ),
                          suffixIconConstraints:
                              const BoxConstraints(minWidth: 0, minHeight: 0),
                          hintText: "Пароль",
                        ),
                        obscureText: true,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var response = await http.post(
                              Uri.parse('https://httpbin.org/post'),
                              body: {
                                "username": _emailController.text.trim(),
                                "password": _passwordController.text.trim(),
                              });
                          if (response.statusCode == 200) {
                            //context.go()
                          }
                        }
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Авторизироваться"),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Вы у нас впервые?",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  TextButton(
                      onPressed: () => context.go('/registration'),
                      child: const Text(
                        "Зарегистрируйтесь",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ],
          ),
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