part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationSighUpEvent extends AuthenticationEvent {
  final String email, password, userName, phoneNumber;

  AuthenticationSighUpEvent(
      {required this.email,
      required this.password,
      required this.userName,
      required this.phoneNumber});
}

class AuthenticationSighInEvent extends AuthenticationEvent {
  final String email, password;

  AuthenticationSighInEvent(this.email, this.password);
}

class AuthenticationSighOutEvent extends AuthenticationEvent {}
