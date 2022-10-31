import 'package:dartz/dartz.dart';
import 'package:solid/models/note_model.dart';
import 'package:solid/models/post_model.dart';
import 'package:solid/models/user_model.dart';

import '../../common/error_handler/failure.dart';

abstract class GetDataRepository {
  Future<Either<Failure, List<UserModel>>> getAllUsers();

  Future<Either<Failure, List<NoteModel>>> getAllNotes();

  Future<Either<Failure, List<PostModel>>> getAllPosts();
}
