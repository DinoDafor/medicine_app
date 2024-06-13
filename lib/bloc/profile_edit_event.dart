part of 'profile_edit_bloc.dart';

@immutable
sealed class ProfileEditEvent {}

class ProfileEditChangeUserDataEvent extends ProfileEditEvent {
  final Map<String, dynamic> updatedFields;

  ProfileEditChangeUserDataEvent({required this.updatedFields});

}
