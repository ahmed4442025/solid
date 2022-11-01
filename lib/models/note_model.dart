class NoteModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  NoteModel(this.userId, this.id, this.title, this.completed);

  NoteModel.fromJson(Map<String, dynamic> json, [bool fromDB = false]) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = fromDB ? json['completed'] == 1 : json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['completed'] = completed;
    return data;
  }
}

extension noteEX on NoteModel {}
