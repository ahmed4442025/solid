import 'package:dartz/dartz.dart';
import 'package:solid/data/common/error_handler/failure.dart';
import 'package:solid/data/data_source/database/db_strings_manager.dart';
import 'package:solid/data/repository/data/base_repository.dart';
import 'package:solid/models/note_model.dart';
import 'package:solid/models/post_model.dart';
import 'package:solid/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepo implements GetDataRepository {
  final Database _database;

  DatabaseRepo(this._database);

  @override
  Future<Either<Failure, List<NoteModel>>> getAllNotes() async {
    try {
      List<Map<String, dynamic>> res = await _database
          .rawQuery('SELECT * FROM ${DBStringsManager.notesTable}');
      return right(res.map((e) => NoteModel.fromJson(e)).toList());
    } catch (error) {
      return Left(Failure(-1, "db error"));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    return right([]);
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      List<Map<String, dynamic>> res = await _database
          .rawQuery('SELECT * FROM ${DBStringsManager.usersTable}');
      return right(res.map((e) => UserModel.fromJson(e)).toList());
    } catch (error) {
      return Left(Failure(-1, "db error"));
    }
  }


}
