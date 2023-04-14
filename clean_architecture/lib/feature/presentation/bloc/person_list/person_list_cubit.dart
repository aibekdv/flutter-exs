import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/feature/domain/entities/person_entity.dart';
import 'package:clean_architecture/feature/domain/usecases/get_all_persons.dart';
import 'package:equatable/equatable.dart';

part 'person_list_state.dart';

class PersonListCubit extends Cubit<PersonListState> {
  final GetAllPersons getAllPersons;
  PersonListCubit({required this.getAllPersons}) : super(PersonListInitial());

  int page = 1;

  void loadPerson() async {
    if (state is PersonListLoding) return;

    final currentState = state;
    var oldPerson = <PersonEntity>[];

    if (currentState is PersonListLoaded) {
      oldPerson = currentState.personList;
    }

    emit(PersonListLoding(oldPerson, isFirstFetch: page == 1));

    final failureOrPerson =
        await getAllPersons(GetAllPersonsParams(page: page));

    failureOrPerson.fold(
      (error) => emit(PersonListError(_mapFailureToMessage(error))),
      (character) {
        page++;
        final persons = (state as PersonListLoding).oldPersonList;
        persons.addAll(character);
        emit(PersonListLoaded(persons));
      },
    );
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
