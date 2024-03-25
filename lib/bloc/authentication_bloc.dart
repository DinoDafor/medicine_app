//todo что это?
import 'package:bloc/bloc.dart';
import 'package:medicine_app/utils/token.dart';
import 'package:meta/meta.dart';

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

  _signUp(AuthenticationSighUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState(isLoading: true));

      //todo норм что у меня идут два рааз подряд await/async?
      var response = await _authService.sighUpUser(
          event.email, event.password, event.userName, event.phoneNumber);
      if (response.statusCode == 200) {
        Token.token = response.data["token"];
        // emit() state для на страницу с чатами
      } else if (response.statusCode == 401) {
        //todo обработать
        print("401 ошибка!!!");
        // emit() state ошибка
      }


    emit(AuthenticationSuccessState());
    emit(AuthenticationLoadingState(isLoading: false));
  }

  _signIn(AuthenticationSighInEvent event, Emitter<AuthenticationState> emit) async{
    emit(AuthenticationLoadingState(isLoading: true));
    //todo сделать норм запросы http
    //todo наверное статус коды 4** обрабатываются автоматически dio, придумать что делать
    var response = await _authService.sighInUser(event.email, event.password);
    if (response.statusCode == 200) {
      Token.token = response.data["token"];
      emit(AuthenticationSuccessState());
      emit(AuthenticationLoadingState(isLoading: false));
    } else if (response.statusCode == 401) {
      //todo обработать
      print("401 ошибка!!!");
      // emit() state ошибка
    }
    else if (response.statusCode == 400) {
      //todo обработать
      print("400 ошибка!!!");
      // emit() state ошибка
    }
  }

  _signOut() {}
}
