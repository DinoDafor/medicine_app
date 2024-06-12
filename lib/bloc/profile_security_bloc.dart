import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_security_event.dart';
part 'profile_security_state.dart';

class ProfileSecurityBloc extends Bloc<ProfileSecurityEvent, ProfileSecurityState> {
  ProfileSecurityBloc() : super(ProfileSecurityInitial()) {
    on<ProfileSecurityEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
