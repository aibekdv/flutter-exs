import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/feature/domain/entities/person_entity.dart';
import 'package:clean_architecture/feature/domain/usecases/search_person.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchPerson searchPerson;

  SearchBloc({required this.searchPerson}) : super(SearchInitial()) {
    on<SearchPersonsEvent>(_fetchPersonsToState);
  }
  int page = 1;

  _fetchPersonsToState(
    SearchPersonsEvent event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchLoadingState());
      final failureOrPerson = await searchPerson(
        SearchPersonParams(query: event.query, page: 1),
      );

      failureOrPerson.fold(
        (failure) =>
            emit(SearchErrorState(message: _mapFailureToMessage(failure))),
        (person) {
          page++;
          emit(SearchLoadedState(persons: person));
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Server failure";
      case CasheFailure:
        return "Cash failure";
      default:
        return "Unexpected error";
    }
  }
}
