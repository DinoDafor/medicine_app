part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {
  final bool isLoading;

  AuthenticationLoadingState({required this.isLoading});
}

class AuthenticationSuccessState extends AuthenticationState {}

class AuthenticationSignInSuccessState extends AuthenticationState {}

class AuthenticationSignInLoadingState extends AuthenticationState {
  final bool isLoading;
  AuthenticationSignInLoadingState({required this.isLoading});
}

class AuthenticationFailureState extends AuthenticationState {
  final String errorMessage;

  AuthenticationFailureState(this.errorMessage);
}
