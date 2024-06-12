import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:medicine_app/bloc/profile_edit_service.dart';
import 'package:meta/meta.dart';

import '../utils/user.dart';

part 'profile_edit_event.dart';

part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  final ProfileEditService _profileService = ProfileEditService();

  ProfileEditBloc() : super(ProfileEditInitial()) {
    on<ProfileEditEvent>((event, emit) {});
    on<ProfileEditChangeUserDataEvent>(_changeProfileUserData);
  }

  _changeProfileUserData(ProfileEditChangeUserDataEvent event,
      Emitter<ProfileEditState> emit) async {
    emit(ProfileEditUpdatedLoadingState(isLoading: true));

    Response response =
        await _profileService.postUpdatedData(event.updatedFields);

    emit(ProfileEditUpdatedLoadingState(isLoading: false));

    if (response.statusCode == 200) {
      //todo вынести всё присваивание в UtilsState user, чтобы в блоке менять user;
      User.email = response.data['email'];
      User.firstName = response.data['firstName'];
      User.lastName = response.data['lastName'];
      User.sex = Sex.values.byName(response.data['gender']);
      User.birthDate = response.data['birthDate'];
      User.phoneNumber = response.data['phoneNumber'];

      emit(ProfileEditUpdatedSuccessfulState());
    } else {
      emit(ProfileEditUpdatedErrorState());
    }
  }
}
