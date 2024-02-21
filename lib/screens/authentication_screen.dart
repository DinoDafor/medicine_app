import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_app/bloc/authentication_bloc.dart';

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
                    buildEmailField(),
                    buildPasswordField(),
                    buildAuthButton(context),
                  ],
                ),
              ),
              buildBottomRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildEmailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        //todo доделать валидацию по почте
        // validator: (value) {
        //   if (value != null) {
        //     if (EmailValidator.validate(value)) {
        //       return null;
        //     } else {
        //       return "Email is not valide";
        //     }
        //   }
        // },
        controller: _emailController,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(Icons.alternate_email),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          hintText: "Email",
        ),
      ),
    );
  }

  Padding buildPasswordField() {
    return Padding(
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
                color: Color(0xFF0EBE7E), fontWeight: FontWeight.bold),
          ),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          hintText: "Пароль",
        ),
        obscureText: true,
      ),
    );
  }

  ElevatedButton buildAuthButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationSighInEvent(_emailController.text, _passwordController.text));

//         if (_formKey.currentState!.validate()) {
//
//           var formData = FormData.fromMap({
//             "username": _emailController.text.trim(),
//             "password": _passwordController.text.trim(),
//             "grant_type": '',
//             "scope": '',
//             "client_id": '',
//             "client_secret": '',
//           });
//          var response = await dio.post( 'https://5lzxc7kx-8000.euw.devtunnels.ms/auth/login', data: formData);
//           if (response.statusCode == 200) {
//             Token.token = response.data["access_token"];
//             context.go('/chats');
//           } else if (response.statusCode == 400) {
// //todo обработать
//             print("Ошибка 400: ${response.data}");
//             //"detail": "LOGIN_BAD_CREDENTIALS"
//           } else if (response.statusCode == 422) {
//             print("Ошибка 422: ${response.data}");
// //todo обработать
//           }
//         }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        )),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccessState) {
              context.go('/chats');
            }
          },
          builder: (context, state) {
            return state is AuthenticationLoadingState && state.isLoading
                ? const Text("...")
                : const Text("Авторизироваться");
          },
        ),
      ),
    );
  }

  Row buildBottomRow(BuildContext context) {
    return Row(
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
