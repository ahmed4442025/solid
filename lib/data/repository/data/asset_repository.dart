import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:solid/data/common/error_handler/failure.dart';
import 'package:solid/models/note_model.dart';
import 'package:solid/models/post_model.dart';
import 'package:solid/models/user_model.dart';

import '../../common/error_handler/error_handler.dart';
import 'base_repository.dart';

class AssetRepository implements GetDataRepository {
  @override
  Future<Either<Failure, List<NoteModel>>> getAllNotes() async {
    try {
      String data = await rootBundle.loadString("assets/jsons/all_notes.json");
      Map<String, dynamic> jsonResult = json.decode(data);
      data = ""; // clear ram
      List<NoteModel> l = [];
      for (var element in jsonResult["data"]) {
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
      String data = await rootBundle.loadString("assets/jsons/all_users.json");
      Map<String, dynamic> jsonResult = json.decode(data);
      data = ""; // clear ram
      List<UserModel> l = [];
      for (var element in jsonResult['data']) {
        l.add(UserModel.fromJson(element));
      }
      return right(l);
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() async{
    try {
      String data = await rootBundle.loadString("assets/jsons/all_posts.json");
      Map<String, dynamic> jsonResult = json.decode(data);
      data = ""; // clear ram
      List<PostModel> l = [];
      for (var element in jsonResult['data']) {
        l.add(PostModel.fromJson(element));
      }
      return right(l);
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }
}
