import 'package:flutter/material.dart';
import 'package:solid/presentation/utilm/utilm.dart';
import 'package:solid/app/extensions.dart';
import '../../controllers/home_cubit.dart';
import '../../models/note_model.dart';

class PostsView extends StatelessWidget {
  PostsView({Key? key, required this.listNotes}) : super(key: key);
  final List<NoteModel> listNotes;
  late HomeCubit _cubit;
  @override
  Widget build(BuildContext context) {
    _cubit = HomeCubit.get(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: myBody(),

    );
  }

  Widget myBody() => Column(
    children: [
      UtilM.box20(),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
              itemBuilder: (c, i) => oneTodo(listNotes[i]),
              separatorBuilder: (c, i) => UtilM.box15(),
              itemCount: listNotes.length),
        ),
      ),
    ],
  );

  // one todoWidget
  Widget oneTodo(NoteModel todoModel) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(todoModel.title.orEmpty()),
        Checkbox(value: todoModel.completed, onChanged: null),
      ],
    ),
  );
}
