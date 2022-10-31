import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/app/extensions.dart';
import 'package:solid/controllers/home_cubit.dart';
import 'package:solid/models/user_model.dart';
import 'package:solid/presentation/resources/views_manager.dart';
import 'package:solid/presentation/utilm/utilm.dart';
import 'package:badges/badges.dart';
import 'package:solid/presentation/views/todo_list.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  late HomeCubit _cubit;

  @override
  Widget build(BuildContext context) {
    _cubit = HomeCubit.get(context);
    return Scaffold(
      appBar: AppBar(title: const Text("todo App")),
      body: myBody(),
      floatingActionButton: btAdd(),
    );
  }

  FloatingActionButton? btAdd() {
    return _cubit.canEdit
        ? FloatingActionButton(onPressed: () {
            _cubit.addUser();
          },child: const Icon(Icons.add),)
        : null;
  }

  Widget myBody() => Column(
        children: [
          title(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (p, c) =>
                    (c is HomeInsertUser || c is HomeDeleteUser),
                builder: (context, state) {
                  return ListView.separated(
                      itemBuilder: (c, i) => oneUser(_cubit.lisUsers[i], c),
                      separatorBuilder: (c, i) => UtilM.box15(),
                      itemCount: _cubit.lisUsers.length);
                },
              ),
            ),
          ),
        ],
      );

// one user
  Widget oneUser(UserModel userModel, context) => Container(
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
                  onTap: () => _cubit.deleteUser(userModel.id.orZero()),
                  child: const Icon(Icons.delete_forever)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userModel.username.orEmpty()),
                Text(userModel.email.orEmpty()),
              ],
            ),
            InkWell(
              onTap: () {
                ViewsManager.todoList(
                    context,
                    TodoViewSett(userModel.getNotes(_cubit.lisTodo),
                        userModel.id.orZero()));
              },
              child: Badge(
                  badgeContent:
                      Text("${userModel.getTotalTodo(_cubit.lisTodo)}"),
                  child: const Icon(Icons.note)),
            ),
          ],
        ),
      );

  Widget title() =>
      const SizedBox(height: 50, child: Center(child: Text("data")));
}
