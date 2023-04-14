import 'dart:convert';

import 'package:clean_architecture/core/error/exeption.dart';
import 'package:clean_architecture/feature/data/models/person_model.dart';
import 'package:http/http.dart';

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPerson(String query, int page);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  PersonRemoteDataSourceImpl({required this.client});
  final Client client;

  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl(
      "https://rickandmortyapi.com/api/character/?page=$page");

  @override
  Future<List<PersonModel>> searchPerson(String query, int page) => _getPersonFromUrl(
      "https://rickandmortyapi.com/api/character/?page=$page&?name=$query");


  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    var response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((e) => PersonModel.fromJson(e))
          .toList();
    } else {
      throw ServerExeption();
    }
  }
}
