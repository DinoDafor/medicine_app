//todo что это?
import 'package:bloc/bloc.dart';
import 'package:medicine_app/utils/token.dart';
import 'package:meta/meta.dart';

import '../utils/user.dart';
import 'authentication_service.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService = AuthService();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<AuthenticationSighUpEvent>(_signUp);
    on<AuthenticationSighInEvent>(_signIn);
    on<AuthenticationSighOutEvent>((event, emit) {});
  }

  _signUp(AuthenticationSighUpEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState(isLoading: true));

    var signUpResponse = await _authService.sighUpUser(
        event.email, event.password, event.userName, event.phoneNumber);
    if (signUpResponse.statusCode == 200) {
      Token.token = signUpResponse.data["token"];
      User.email = event.email;

      var userResponse = await _authService.getUser(User.email);
      User.id = userResponse.data["id"];

      emit(AuthenticationSuccessState());
      emit(AuthenticationLoadingState(isLoading: false));
    } else if (signUpResponse.statusCode == 401) {
      // emit() state ошибка
    }
  }

  _signIn(AuthenticationSighInEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState(isLoading: true));

    var signInResponse =
        await _authService.sighInUser(event.email, event.password);
    if (signInResponse.statusCode == 200) {
      Token.token = signInResponse.data["token"];
      User.email = event.email;
      var userResponse = await _authService.getUser(User.email);
      User.id = userResponse.data["id"];

      emit(AuthenticationSuccessState());
      emit(AuthenticationLoadingState(isLoading: false));
    } else if (signInResponse.statusCode == 401) {
    } else if (signInResponse.statusCode == 400) {}
  }
}
