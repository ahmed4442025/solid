import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/models/user_model.dart';
import 'package:solid/presentation/utilm/utilm.dart';
import 'package:solid/app/extensions.dart';
import '../../controllers/home_cubit.dart';
import '../../models/note_model.dart';

class TodoList extends StatelessWidget {
  TodoList({Key? key, required this.todoViewSett}) : super(key: key);
  final TodoViewSett todoViewSett;
  late HomeCubit _cubit;

  @override
  Widget build(BuildContext context) {
    _cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Notes")),
          body: myBody(),
          floatingActionButton: btAdd(),
        );
      },
    );
  }

  FloatingActionButton? btAdd() {
    return _cubit.canEdit
        ? FloatingActionButton(
            onPressed: () {
              _cubit.addNote(todoViewSett.userId);
            },
            child: Icon(Icons.add),
          )
        : null;
  }

  Widget myBody() => Column(
        children: [
          UtilM.box20(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                  itemBuilder: (c, i) =>
                      oneTodo(_cubit.getUserById(todoViewSett.userId)[i]),
                  separatorBuilder: (c, i) => UtilM.box15(),
                  itemCount: _cubit.getUserById(todoViewSett.userId).length),
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
            // delete
            if (_cubit.canEdit)
              InkWell(
                  onTap: () => _cubit.deleteNote(todoModel.id.orZero()),
                  child: const Icon(Icons.delete_forever)),
            // update
            // if (_cubit.canEdit)
            //   InkWell(
            //       onTap: () => _cubit.updateNote(todoViewSett.userId,todoModel.id.orZero()),
            //       child: const Icon(Icons.edit)),
            Text(todoModel.title.orEmpty()),
            // Checkbox(value: todoModel.completed, onChanged: null),
          ],
        ),
      );
}

class TodoViewSett {
  final List<NoteModel> listNotes;
  final int userId;

  TodoViewSett(this.listNotes, this.userId);
}
