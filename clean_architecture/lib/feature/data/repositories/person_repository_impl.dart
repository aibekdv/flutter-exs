import 'package:clean_architecture/core/error/exeption.dart';
import 'package:clean_architecture/core/platforms/network_info.dart';
import 'package:clean_architecture/feature/data/datasources/person_local_datasource.dart';
import 'package:clean_architecture/feature/data/datasources/person_remote_datasource.dart';
import 'package:clean_architecture/feature/data/models/person_model.dart';
import 'package:clean_architecture/feature/domain/entities/person_entity.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/feature/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class PersonRepositoryImpl implements PersonRepository {
  final NetworkInfo networkInfo;
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;

  PersonRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() => remoteDataSource.getAllPersons(page));
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query, int page) async {
    return await _getPersons(() => remoteDataSource.searchPerson(query,page));
  }

  Future<Either<Failure, List<PersonEntity>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePersons = await getPersons();
        localDataSource.personsToCashe(remotePersons);
        return Right(remotePersons);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastPersonsFromCashe();
        return Right(localPerson);
      } on CasheExeption {
        return Left(CasheFailure());
      }
    }
  }
}
