import 'package:solid/data/data_source/database/db_strings_manager.dart';
import 'package:sqflite/sqflite.dart';

import 'db_models.dart';

class DBFactory {
  Future<Database> getDB() async {
    late Database database;
    await openDatabase(DBStringsManager.dbName, version: 1,
        onCreate: (db, version) async {
      print('db created');

      String usersQ = _createUsersTableQuery();
      String notesQ = _createNotesTableQuery();

      // create users
      await db.execute(usersQ).then((value) {
        print('users table created');
      }).catchError((error) {
        print('ERROR when creating table ${error.toString()}');
      });

      // create notes
      await db.execute(notesQ).then((value) {
        print('notes table created');
      }).catchError((error) {
        print('ERROR when creating table ${error.toString()}');
      });


    }, onOpen: (db) async {
      database = db;
    });
    return database;
  }

  String _createUsersTableQuery() {
    return 'CREATE TABLE ${DBStringsManager.usersTable}'
        ' ('
        '${DBStringsManager.usersId} INTEGER PRIMARY KEY,'
        ' ${DBStringsManager.usersUsername} TEXT,'
        ' ${DBStringsManager.usersEmail} TEXT'
        ' )';
  }

  String _createNotesTableQuery() {
    return 'CREATE TABLE ${DBStringsManager.notesTable}'
        ' ('
        '${DBStringsManager.notesId} INTEGER PRIMARY KEY,'
        ' ${DBStringsManager.notesTitle} TEXT,'
        ' ${DBStringsManager.notesUserId} INTEGER,'
        ' ${DBStringsManager.noteIsDone} BOOLEAN'
        ' )';
  }




}
