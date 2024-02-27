part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {
  final BuildContext context;

  const NavigationEvent({required this.context});
}

class NavigationToAuthenticationScreenEvent extends NavigationEvent {
  const NavigationToAuthenticationScreenEvent({required super.context});
}

class NavigationToRegistrationScreenEvent extends NavigationEvent {
  const NavigationToRegistrationScreenEvent({required super.context});
}

class NavigationToChatsScreenEvent extends NavigationEvent {
  const NavigationToChatsScreenEvent({required super.context});
}

class NavigationToChatScreenEvent extends NavigationEvent {
  final int chatId;

  const NavigationToChatScreenEvent(
      {required super.context, required this.chatId});
}
