import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:masked_text/masked_text.dart';
import 'package:medicine_app/bloc/authentication_bloc.dart';
import 'package:medicine_app/screen_lock_services/AuthenticationService.dart';

import '../bloc/navigation_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _validatePhone = true;
  bool _validateEmail = true;

  Future<bool> get hasBioAuth async {
    return await localAuth.canCheckBiometrics;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
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
                    //todo Правильно ли я сделал что декопозировал именно так поля?
                    buildEmailField(),
                    buildNameField(),
                    buildPhoneField(),
                    buildPasswordField(),
                    buildConfirmPasswordField(),
                    buildRegisterButton(context),
                  ],
                ),
              ),
            ),
            buttomRow(context),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      //todo вынести валидацию из UI
      validator: (value) {
        if (value != null) {
          if (EmailValidator.validate(value)) {
            return null;
          } else {
            return "Введите корректную почту";
          }
        }
      },
      controller: _emailController,
      decoration: buildInputDecoration("Email ID", 10, Icons.alternate_email),
    );
  }

  TextFormField buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      // validator: (value) {
      //   if (_confirmPasswordController.text != _passwordController.text) {
      //     return "Пароли не совпадают";
      //   }
      //   return null;
      // },
      decoration: buildInputDecoration("Ещё раз пароль", 10, Icons.shield),
      obscureText: true,
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      //todo вынести валидацию из UI
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите пароль';
        }
        return null;
      },
      decoration: buildInputDecoration("Пароль", 10, Icons.shield),
      obscureText: true,
    );
  }

  MaskedTextField buildPhoneField() {
    return MaskedTextField(
        mask: "+#(###) ###-##-##",
        keyboardType: TextInputType.number,

        //todo вынести валидацию из UI
        validator: validatorPhone,

        // (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Phone number can not be empty';
        //   }
        //   if (isMobileNumberValid(value)) {
        //     return null;
        //   } else {
        //     return "Phone number is not valide!";
        //   }
        // },
        controller: _phoneNumberController,

        ///  decoration: buildInputDecoration("Номер телефона", 10, Icons.phone),
        decoration: InputDecoration(
          prefixIcon: Container(
              margin: EdgeInsets.only(right: 10), child: Icon(Icons.phone)),
          labelText: "Номер телефона",
          hintText: "+7(***) ***-**-**",
          // fillColor: (_validatePhone == true)
          //     ? const Color.fromARGB(255, 255, 251, 254)
          //     : Color.fromARGB((255 * 0.15).toInt(), 235, 87, 87),
          // filled: true,
          // border: OutlineInputBorder(
          //     borderSide: BorderSide.none,
          //     borderRadius: BorderRadius.circular(15))),
        ));
  }

  TextFormField buildNameField() {
    return TextFormField(
      controller: _nameController,
      //todo вынести валидацию из UI
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите имя';
        }
        return null;
      },
      decoration: buildInputDecoration("Ваше имя", 10, Icons.person),
    );
  }

  ElevatedButton buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationSighUpEvent(
                  email: _emailController.text,
                  password: _passwordController.text,
                  userName: _nameController.text,
                  phoneNumber: _phoneNumberController.text));
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        )),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            final hasBio = await this.hasBioAuth;

            if (state is AuthenticationSuccessState) {
              if (hasBio) {
                // Navigator.pushNamed(context, 'onboarding',
                //     arguments: ScreenArgs(email: _emailController.text));
                Map<String, String> cred = {
                  "email": _emailController.text,
                  "password": _passwordController.text,
                };
                if (_formKey.currentState!.validate()) {
                  //todo delete
                  BlocProvider.of<NavigationBloc>(context).add(
                      NavigationToOnBoardingScreenEvent(
                          context: context,
                          credentials: ScreenArgs(
                              email: _emailController.text,
                              password: _passwordController.text)));
                }
              } else {
                context.go('/chats');

                //   ///Navigator.pushNamed(context, 'home');
              }

              // BlocProvider.of<NavigationBloc>(context)
              //     .add(NavigationToChatsScreenEvent(context: context));
            }
          },
          builder: (context, state) {
            return state is AuthenticationLoadingState && state.isLoading
                ? const Text("...")
                : const Text("Зарегистрироваться");
          },
        ),
      ),
    );
  }

  Row buttomRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Вы уже регистрировались?",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        TextButton(
            onPressed: () async {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationToAuthenticationScreenEvent(context: context));
            },
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
    );
  }

  //todo Вынести логику из UI
  // bool isMobileNumberValid(String phoneNumber) {
  //   const String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
  //   var regExp = RegExp(regexPattern);

  //   if (phoneNumber.isEmpty) {
  //     return false;
  //   } else if (regExp.hasMatch(phoneNumber)) {
  //     return true;
  //   }
  //   return false;
  // }

  String? validatorPhone(String? phone) {
    if ((phone!.isEmpty) || (phone!.length < 10)) {
      _validatePhone = false;
      setState(() {});
      return "Введите номер телефона";
    }
  }

  InputDecoration buildInputDecoration(
      String hint, double margin, IconData iconData) {
    return InputDecoration(
      prefixIcon: Container(
          margin: EdgeInsets.only(right: margin), child: Icon(iconData)),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
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
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

class ScreenArgs {
  final String email;
  final String password;

  ScreenArgs({required this.email, required this.password});
}
