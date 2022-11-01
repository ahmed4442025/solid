import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:solid/data/repository/control_repo.dart';
import 'package:solid/data/repository/data/base_repository.dart';
import 'package:solid/models/note_model.dart';
import 'package:solid/models/post_model.dart';
import 'package:solid/models/user_model.dart';
import 'dart:math';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._dataRepository, [this._control]) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  final GetDataRepository _dataRepository;
  final RepoControl? _control;

  List<NoteModel> lisTodo = [];
  List<UserModel> lisUsers = [];
  List<PostModel> lisPosts = [];
  bool canEdit = false;

  Future<void> init() async {
    // _tempGenerate();
    await _getData();
    // _test();
  }

  Future<void> _getData() async {
    var resNotes = await _dataRepository.getAllNotes();
    resNotes.fold((l) => lisTodo = [], (r) => lisTodo = r);

    var resUsers = await _dataRepository.getAllUsers();
    resUsers.fold((l) => lisUsers = [], (r) => lisUsers = r);

    (await _dataRepository.getAllPosts())
        .fold((l) => lisPosts = [], (r) => lisPosts = r);
    if (_control != null) canEdit = true;
  }

  void _tempGenerate() {
    lisTodo = [
      NoteModel(1, 1, "title 1", false),
      NoteModel(2, 2, "title 2", false),
      NoteModel(1, 3, "title 3", true),
      NoteModel(2, 4, "title 4", false),
    ];

    lisUsers = [
      UserModel(id: 1, email: "email@ff.com", name: "name 1"),
      UserModel(id: 2, email: "email@ff.com", name: "name 2"),
      UserModel(id: 3, email: "email@ff.com", name: "name 3"),
      UserModel(id: 4, email: "email@ff.com", name: "name 4"),
      UserModel(id: 5, email: "email@ff.com", name: "name 5"),
    ];
    lisPosts = [
      PostModel(userId: 1, id: 1, title: "title 1", body: "body"),
      PostModel(userId: 1, id: 2, title: "title 2", body: ""),
      PostModel(userId: 2, id: 3, title: "title 3", body: ""),
      PostModel(userId: 3, id: 4, title: "title 4", body: ""),
    ];
  }

  void addUser() async {
    if (_canControll()) return;
    UserModel user =
        UserModel(username: _getRandomString(8), email: _getRandomString(20));
    await _control!.insertUser(user);
    _getData();
    emit(HomeInsertUser());
  }

  void deleteUser(int id) async {
    if (_canControll()) return;
    await _control!.deleteUser(id);
    _getData();
    emit(HomeInsertUser());
  }

  void addNote(int userId) async {
    if (_canControll()) return;
    NoteModel note =
        NoteModel(userId, -1, _getRandomString(15), _rnd.nextBool());
    await _control!.insertNote(note);
    _getData();
    emit(HomeInsertUser());
  }

  void deleteNote(int id) async {
    if (_canControll()) return;
    await _control!.deleteNote(id);
    _getData();
    emit(HomeInsertUser());
  }

  void updateNote(int userId, int noteId, [bool? value]) async {
    if (_canControll()) return;
    NoteModel note = NoteModel(
        userId, noteId, _getRandomString(15), value ?? _rnd.nextBool());
    await _control!.updateNote(note);
    _getData();
    emit(HomeInsertUser());
  }

  bool _canControll() => (!canEdit || _control == null);

  List<NoteModel> getUserById(int id) {
    UserModel user = UserModel();
    for (var element in lisUsers) {
      if (element.id == id) user = element;
    }
    return user.getNotes(lisTodo);
  }

  // ---------------------
  final String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
