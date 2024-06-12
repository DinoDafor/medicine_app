part of 'profile_edit_bloc.dart';

@immutable
sealed class ProfileEditState {}

final class ProfileEditInitial extends ProfileEditState {}

final class ProfileEditUpdatedSuccessfulState extends ProfileEditState {}

final class ProfileEditUpdatedLoadingState extends ProfileEditState {
  final bool isLoading;

  ProfileEditUpdatedLoadingState({required this.isLoading});
}

final class ProfileEditUpdatedErrorState extends ProfileEditState {}
