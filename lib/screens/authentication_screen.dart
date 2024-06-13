import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_app/bloc/authentication_bloc.dart';
import 'package:medicine_app/bloc/navigation_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:medicine_app/screen_lock_services/AuthenticationService.dart';
import 'package:medicine_app/screens/lock_screens/passcodePage.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<bool> get hasBio async {
    List<BiometricType> availableBiometrics =
        await localAuth.getAvailableBiometrics();
    return availableBiometrics.length > 0;
  }

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
                    _buildEmailField(),
                    buildPasswordField(),
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ElevatedButton(
                              onPressed: () async {
                                final isSupportBioAuth =
                                    await authService.checkSupportBioAuth();
                                if (isSupportBioAuth) {
                                  bool isAuthenticated = await localAuth
                                      .authenticate(localizedReason: 'Login');
                                  if (isAuthenticated) {
                                    print("GET AFTER SAFE ");
                                    final creds =
                                        await authService.getCredsByBio();
                                    print(creds);
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(AuthenticationSighInEvent(
                                            creds!["email"],
                                            creds["password"]));
                                  }
                                } else {
                                  print("NOT CHOOOOOSE AUTH");
                                  String? enteredCode = await context
                                      .pushNamed<String>('passcodePage');
                                  if (enteredCode != null) {
                                    print("Finally crreeeeds, ${enteredCode} ");

                                    final creds = await authService
                                        .getCredsByCode(enteredCode!);
                                    print("WEEEE, ${creds}");
                                    print(creds!["email"]);
                                    print(creds["password"]);
                                    print(creds["email"].runtimeType);
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(AuthenticationSighInEvent(
                                            creds!["email"],
                                            creds["password"]));
                                    print("After bloc provider");
                                  }
                                }
                              },
                              // tooltip: "Bio Login",
                              child: BlocConsumer<AuthenticationBloc,
                                  AuthenticationState>(
                                builder: (context, state) {
                                  return state
                                              is AuthenticationSignInLoadingState &&
                                          state.isLoading
                                      ? const Text("...")
                                      : const Text(
                                          "Войти с помощью биометрии или пин-кода");
                                },
                                listener: (context, state) async {
                                  if (state
                                      is AuthenticationSignInSuccessState) {
                                    BlocProvider.of<NavigationBloc>(context)
                                        .add(
                                      NavigationToChatsScreenEvent(
                                          context: context),
                                    );
                                  }
                                },
                              ));
                        }
                        return Container();
                      },
                      future: this.hasBio,
                    ),
                    _buildAuthButton(context),
                  ],
                ),
              ),
              _buildBottomRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildEmailField() {
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

  ElevatedButton _buildAuthButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationSighInEvent(
                _emailController.text, _passwordController.text));
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
            //todo возможно убрать ненужный стейт, точнее иф
            if (state is AuthenticationSuccessState) {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationToChatsScreenEvent(context: context));
            }
          },
          builder: (context, state) {
            return state is AuthenticationLoadingState && state.isLoading
                ? const CircularProgressIndicator(backgroundColor: Colors.white)
                : const Text("Авторизироваться");
          },
        ),
      ),
    );
  }

  Row _buildBottomRow(BuildContext context) {
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
            onPressed: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationToRegistrationScreenEvent(context: context));
            },
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
