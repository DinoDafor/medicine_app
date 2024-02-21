//todo что это?
import 'package:bloc/bloc.dart';
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

  _signUp(AuthenticationSighUpEvent event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationLoadingState(isLoading: true));
    //todo сделать норм запросы http
    _authService.sighUpUser(
        event.email, event.password, event.userName, event.phoneNumber);

    emit(AuthenticationSuccessState());
    emit(AuthenticationLoadingState(isLoading: false));
  }

  _signIn(AuthenticationSighInEvent event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationLoadingState(isLoading: true));
    //todo сделать норм запросы http
    _authService.sighInUser(event.email, event.password);

    emit(AuthenticationSuccessState());

    emit(AuthenticationLoadingState(isLoading: false));
  }

  _signOut() {}
}
