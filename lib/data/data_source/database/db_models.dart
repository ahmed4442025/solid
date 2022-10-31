import 'package:solid/data/data_source/database/db_strings_manager.dart';
import 'package:solid/models/note_model.dart';
import 'package:solid/models/user_model.dart';

extension NoteEX on NoteModel {
  String toDBUpdate() {
    return 'UPDATE ${DBStringsManager.notesTable} '
        'SET ${DBStringsManager.notesUserId} = ?,'
        ' ${DBStringsManager.notesTitle} = ?,'
        ' ${DBStringsManager.noteIsDone} = ?'
        'WHERE ${DBStringsManager.notesId} = ?';
  }

  List<dynamic> toValues() => [userId, title, completed == true ? 1 : 0, id];




String toInsert() {
  String names = '${DBStringsManager.notesUserId},'
      ' ${DBStringsManager.notesTitle},'
      ' ${DBStringsManager.noteIsDone}';
  String values = '"$userId", "$title", "$completed"';
  return 'INSERT INTO ${DBStringsManager.notesTable}($names) VALUES($values)';
}}

extension UserEx on UserModel {
  String toInsertQuery() {
    String names = '${DBStringsManager.usersUsername},'
        ' ${DBStringsManager.usersEmail}';
    String values = '"$username", "$email"';
    print('INSERT INTO ${DBStringsManager.usersTable}($names) VALUES($values)');
    return 'INSERT INTO ${DBStringsManager.usersTable}($names) VALUES($values)';
  }
}
