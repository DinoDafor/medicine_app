import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_app/screens/registration_screen.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<NavigationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<NavigationToAuthenticationScreenEvent>(_onAuthenticationScreen);
    on<NavigationToRegistrationScreenEvent>(_onRegistrationScreen);
    on<NavigationToChatsScreenEvent>(_onChatsScreen);
    on<NavigationToChatScreenEvent>(_onChatScreen);
    on<NavigationToOnBoardingScreenEvent>(_onBoardingScreen);
  }

  _onAuthenticationScreen(NavigationToAuthenticationScreenEvent event,
      Emitter<NavigationState> emit) {
    event.context.go("/authentication");
  }

  _onRegistrationScreen(NavigationToRegistrationScreenEvent event,
      Emitter<NavigationState> emit) {
    event.context.go("/registration");
  }

  _onBoardingScreen(
      NavigationToOnBoardingScreenEvent event, Emitter<NavigationState> emit) {
    // Navigator.pushNamed(
    //   event.context,
    //   '/onboarding',
    //   arguments: ScreenArgs(credentials: {
    //     "email": 'Extract Arguments Screen',
    //     "password": 'This message is extracted in the build method.',
    //   }),
    // );
    log(event.credentials.email);
    event.context.go("/onboarding", extra: event.credentials);
  }

  _onChatsScreen(
      NavigationToChatsScreenEvent event, Emitter<NavigationState> emit) {
    event.context.go("/chats");
  }

  _onChatScreen(
      NavigationToChatScreenEvent event, Emitter<NavigationState> emit) {
    event.context.go("/chats/chat", extra: event.chatId);
  }
}
