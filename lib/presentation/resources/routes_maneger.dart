import 'package:flutter/material.dart';
import 'package:solid/models/note_model.dart';
import 'package:solid/presentation/views/todo_list.dart';
import '../views/home/home_view.dart';
import '../views/splash_screen.dart';

class Routes {
  static const String home = "/home";
  static const String todoList = "/todoList";
  static const String splashRout = "/";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRout:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      // home
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      // todoList
      case Routes.todoList:
        return MaterialPageRoute(
            builder: (_) =>
                TodoList(todoViewSett: settings.arguments as TodoViewSett));
      default:
        return _unDefinedRout();
    }
  }

  static Route<dynamic> _unDefinedRout() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("noRouteFound"),
              ),
              body: const Center(
                child: Text("noRouteFound"),
              ),
            ));
  }
}
