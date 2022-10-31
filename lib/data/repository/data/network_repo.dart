import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:solid/data/common/error_handler/error_handler.dart';
import 'package:solid/data/common/error_handler/failure.dart';
import 'package:solid/data/repository/data/base_repository.dart';
import 'package:solid/models/note_model.dart';
import 'package:solid/models/post_model.dart';
import 'package:solid/models/user_model.dart';

class NetworkRepo implements GetDataRepository {
  Dio _dio;

  NetworkRepo(this._dio);

  @override
  Future<Either<Failure, List<NoteModel>>> getAllNotes() async {
    try {
      var res = await _dio.get("/todos");
      List<NoteModel> l = [];
      for (var element in res.data) {
        l.add(NoteModel.fromJson(element));
      }
      return right(l);
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      var res = await _dio.get("/users");
      List<UserModel> l = [];
      for (var element in res.data) {
        l.add(UserModel.fromJson(element));
      }
      return right(l);
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    try {
      var res = await _dio.get("/posts");
      List<PostModel> l = [];
      for (var element in res.data) {
        l.add(PostModel.fromJson(element));
      }
      return right(l);
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }
}
