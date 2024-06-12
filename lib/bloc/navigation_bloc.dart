import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    on<NavigationToSearchScreenEvent>(_onSearchScreen);
    on<NavigationToProfileMainScreenEvent>(_onProfileMainScreen);
    on<NavigationToProfileEditScreenEvent>(_onProfileEditScreen);
    on<NavigationToProfileSecurityScreenEvent>(_onProfileSecurityScreen);
  }

  _onAuthenticationScreen(NavigationToAuthenticationScreenEvent event,
      Emitter<NavigationState> emit) {
    event.context.go("/");
  }

  _onRegistrationScreen(NavigationToRegistrationScreenEvent event,
      Emitter<NavigationState> emit) {
    event.context.go("/registration");
  }

  _onChatsScreen(
      NavigationToChatsScreenEvent event, Emitter<NavigationState> emit) {
    event.context.go("/chats");
  }

  _onChatScreen(
      NavigationToChatScreenEvent event, Emitter<NavigationState> emit) {
    event.context.go("/chats/chat", extra: event.chatId);
  }

  _onSearchScreen(
      NavigationToSearchScreenEvent event, Emitter<NavigationState> emit) {
    event.context.go("/chats/search");
  }

  _onProfileMainScreen(
      NavigationToProfileMainScreenEvent event, Emitter<NavigationState> emit) {
    event.context.go("/chats/profile");
  }

  _onProfileEditScreen(
      NavigationToProfileEditScreenEvent event, Emitter<NavigationState> emit) {
    event.context.go("/chats/profile/edit");
  }

  _onProfileSecurityScreen(NavigationToProfileSecurityScreenEvent event,
      Emitter<NavigationState> emit) {
    event.context.go("/chats/profile/security");
  }
}
