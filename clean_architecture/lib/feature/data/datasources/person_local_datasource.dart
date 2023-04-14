import 'dart:async';
import 'dart:convert';

import 'package:clean_architecture/core/error/exeption.dart';
import 'package:clean_architecture/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCashe();
  void personsToCashe(List<PersonModel> persons);
}

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;
  PersonLocalDataSourceImpl({required this.sharedPreferences});

  static const String CASHED_PERSONS_LIST = 'CASHED_PERSONS_LIST';

  @override
  Future<List<PersonModel>> getLastPersonsFromCashe() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CASHED_PERSONS_LIST);

    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((e) => PersonModel.fromJson(json.decode(e)))
          .toList());
    } else {
      throw CasheExeption();
    }
  }

  @override
  Future personsToCashe(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((e) => json.encode(e.toJson())).toList();

    sharedPreferences.setStringList(CASHED_PERSONS_LIST, jsonPersonsList);
    return Future.value(jsonPersonsList);
  }
}
