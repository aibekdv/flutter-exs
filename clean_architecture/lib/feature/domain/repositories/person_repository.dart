import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/feature/domain/entities/person_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PersonRepository{
  Future<Either<Failure,List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure,List<PersonEntity>>>  searchPerson(String query, int page);
}