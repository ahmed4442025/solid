import 'package:solid/data/data_source/database/db_models.dart';
import 'package:solid/data/data_source/database/db_strings_manager.dart';
import 'package:solid/models/note_model.dart';
import 'package:solid/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class RepoControl {
  Future<void> insertNote(NoteModel noteModel);

  Future<void> updateNote(NoteModel noteModel);

  Future<void> deleteNote(int id);

  Future<void> insertUser(UserModel userModel);

  Future<void> deleteUser(int id);
}

class DataBaseControl implements RepoControl {
  final Database _db;

  DataBaseControl(this._db);

  @override
  Future<void> deleteNote(int id) async {
    try {
      await _db.delete(DBStringsManager.notesTable,
          where: '${DBStringsManager.notesId} = ?', whereArgs: [id]);
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  Future<void> insertNote(NoteModel noteModel) async {
    try {
      await _db.rawQuery(noteModel.toInsert());
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  Future<void> insertUser(UserModel userModel) async {
    try {
      await _db.rawQuery(userModel.toInsertQuery());
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  Future<void> updateNote(NoteModel noteModel) async {
    try {
      await _db.rawUpdate(noteModel.toDBUpdate(),noteModel.toValues());
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      await _db.delete(DBStringsManager.usersTable,
          where: '${DBStringsManager.usersId} = ?', whereArgs: [id]);
    } catch (e) {
      print("Error : $e");
    }
  }
}
