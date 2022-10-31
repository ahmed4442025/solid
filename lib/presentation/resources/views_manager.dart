import 'package:flutter/material.dart';
import '../../models/note_model.dart';
import '../views/todo_list.dart';
import 'routes_maneger.dart';

class ViewsManager {
  // =============== const pages =================
  // ------------ with out back ------------

  // homeAfterSplash
  static void homeAfterSplash(context) {
    home(context);
  }

  // home
  static void home(context) {
    _openViewNoBack(context, Routes.home);
  }

  // todoList
  static void todoList(context, TodoViewSett todoViewSett) {
    _openViewWithBack(context, Routes.todoList, todoViewSett);
  }

  // ------------ with back ------------
  // NOTE : "WB" (with back) in the end of function name that mean you can use back button

  // go back if you can
  static void backIfUCan(context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // ========== privet methods ==========

  // user can't back to last page
  static void _openViewNoBack(context, nextPage, [Object? arg]) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(nextPage, (route) => false, arguments: arg);
  }

  // user can back to last page
  static void _openViewWithBack(context, nextPage, [Object? arg]) {
    Navigator.of(context).pushNamed(nextPage, arguments: arg);
  }
}
