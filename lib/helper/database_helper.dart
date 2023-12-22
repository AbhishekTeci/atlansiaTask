import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user_data_local_model.dart';
import '../model/user_data_model.dart';

class DatabaseHelper{

  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  //connect with sql database
  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'atlassian.db');
    debugPrint('dbPath $path');

    // Check if the database exists

    // open the database
    var db = await openDatabase(path, readOnly: false);

    return db;
  }



  insertUserData(UserDataModel userDataModel) async {
    final db1 = await db;
    db1!.insert('USER_DATA', userDataModel as Map<String, Object?>);
  }



  Future<List<UserDataModel>> getItems() async {
    final db1 =  await db;
    final List<Map<String, Object?>> queryResult =
    await db1!.query('USER_DATA', );
    return queryResult.map((e) => UserDataModel.fromJson(e)).toList();
  }






}