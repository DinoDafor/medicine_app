import 'package:bloc/bloc.dart';
import 'package:medicine_app/bloc/search_service.dart';
import 'package:medicine_app/models/doctor_model.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService searchService = SearchService();

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});

    on<SearchSendEmailOfDoctorEvent>(_onSend);
  }

  _onSend(SearchSendEmailOfDoctorEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState(isLoading: true));

    Doctor? doctor = await searchService.getDoctorsByEmail(event.email);
    emit(SearchLoadingState(isLoading: false));
    if (doctor == null) {
      emit(SearchDoctorNotFoundState());
    } else {
      emit(SearchFindDoctorsSuccessfullyState(doctor: doctor));
    }
  }
}
