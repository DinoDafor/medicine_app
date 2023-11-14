import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Регистрация",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
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
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(Icons.alternate_email),
                        ),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                        hintText: "Email ID",
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name can not be empty';
                        }
                        return null;
                      },
                      decoration: buildInputDecoration("Ваше имя"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number can not be empty';
                        }
                        return null;
                      },
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Icon(Icons.shield)),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                        hintText: "Номер телефона",
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password can not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Icon(Icons.shield)),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                        hintText: "Пароль",
                      ),
                      obscureText: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Icon(Icons.shield)),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                        hintText: "Повторите пароль",
                      ),
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var response = await http.post(
                              Uri.parse('https://httpbin.org/post'),
                              body: {
                                "email": _emailController.text.trim(),
                                "password": _passwordController.text.trim(),
                                //todo дополнить запрос
                              });
                          if (response.statusCode == 200) {
                            // context.go(location);
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
                        padding: EdgeInsets.all(8.0),
                        child: Text("Зарегистрироваться"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Вы уже регистрировались?",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                TextButton(
                    onPressed: () => context.go("/"),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Войти",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String hint) {
    return InputDecoration(
                      prefixIcon: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(Icons.shield)),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),
                      hintText: hint,
                    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
