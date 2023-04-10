import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:read_write_file/models/user.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  static const String userTable = 'User';
  static const String columnId = 'id';
  static const String columnName = 'name';

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB();
    return _database;
  }

  Future<Database?> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}Student.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // User
  // ID | NAME
  void _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $userTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)',
    );
  }

  // READ
  Future<List<User>> getUsers() async {
    Database? db = await database;
    final List<Map<String, dynamic>> userMapList = await db!.query(userTable);
    final List<User> userList = [];
    for (var element in userMapList) {
      userList.add(User.fromMap(element));
    }

    return userList;
  }

  // Insert
  Future<User> insertUser(User user) async {
    Database? db = await database;
    user.id = await db!.insert(userTable, user.toMap());
    return user;
  }

  // Update
  Future<int> updateUser(User user) async {
    Database? db = await database;
    return await db!.update(
      userTable,
      user.toMap(),
      where: '$columnId = ?',
      whereArgs: [user.id],
    );
  }

  // Delete
  Future<int> deleteUser(int id) async {
    Database? db = await database;
    return await db!.delete(
      userTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
