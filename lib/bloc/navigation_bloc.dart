import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  }

  _onAuthenticationScreen(NavigationToAuthenticationScreenEvent event,
      Emitter<NavigationState> emit) {
    event.context.go("/");
  }
  _onRegistrationScreen(NavigationToRegistrationScreenEvent event,
      Emitter<NavigationState> emit) {
    event.context.go("/registration");
  }
  _onChatsScreen(NavigationToChatsScreenEvent event,
      Emitter<NavigationState> emit) {
    event.context.go("/chats");
  }

  _onChatScreen(NavigationToChatScreenEvent event,
      Emitter<NavigationState> emit) {
    event.context.go("/chats/chat", extra: event.chatId);
  }
}
