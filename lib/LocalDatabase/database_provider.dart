/*
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database _database;


  Future<Database> get database async {
    // If database exists, return database
    if(_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();
    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path,'photo_manage.db');
  }

}
*/
