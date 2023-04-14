import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/usecase/usecase.dart';
import 'package:clean_architecture/feature/domain/entities/person_entity.dart';
import 'package:clean_architecture/feature/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllPersons extends UseCase<List<PersonEntity>,GetAllPersonsParams>{
  final PersonRepository personRepository;

  GetAllPersons(this.personRepository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(GetAllPersonsParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class GetAllPersonsParams extends Equatable {
  final int page;

  const GetAllPersonsParams({required this.page});

  @override
  List<Object?> get props => [page];
}
