part of 'person_list_cubit.dart';

abstract class PersonListState extends Equatable {
  const PersonListState();

  @override
  List<Object> get props => [];
}

class PersonListInitial extends PersonListState {}

class PersonListLoding extends PersonListState {
  final List<PersonEntity> oldPersonList;
  final bool isFirstFetch;

  const PersonListLoding(this.oldPersonList, {required this.isFirstFetch});

  @override
  List<Object> get props => [oldPersonList];
}

class PersonListLoaded extends PersonListState {
  final List<PersonEntity> personList;

  const PersonListLoaded(this.personList);

  @override
  List<Object> get props => [personList];
}

class PersonListError extends PersonListState {
  final String message;

  const PersonListError(this.message);

  @override
  List<Object> get props => [message];
}
