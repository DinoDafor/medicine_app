import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_app/bloc/search_bloc.dart';

//todo: прочитать про AutoComplete класс для поиска
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Users'),
      ),
      body: _buildSearchBody(context),
    );
  }

  Widget _buildSearchBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Enter username',
              prefixIcon: Icon(Icons.search),
            ),
            onSubmitted: (String email) {
              BlocProvider.of<SearchBloc>(context)
                  .add(SearchSendEmailOfDoctorEvent(email: email));
            },
          ),
          const SizedBox(height: 16.0),
          _buildDoctorsList(context),
        ],
      ),
    );
  }

  Widget _buildDoctorsList(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoadingState && state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchFindDoctorsSuccessfullyState) {
          return Expanded(
            child: ListView.builder(
                //todo: hardcode
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.doctor.firstName),
                    subtitle: Text(state.doctor.email),
                    //todo при нажатии попадаем в чат с доктором
                    // onTap: ,
                  );
                }),
          );
        } else if (state is SearchDoctorNotFoundState) {
          return const Center(
              child: Text("Доктор с таким email не был найден"));
        } else {
          return const Center();
        }
      },
    );
  }
}

// POST /conversations с телом
// {firstParticipantId: 1,
// secondParticipantId:2}
//
// это создание пустого диалога
//
// GET /users
// параметры userEmail, role
// для поиска
//
// роль указываешь DOCTOR
