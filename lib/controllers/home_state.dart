part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeInsertUser extends HomeState {}

class HomeInsertNote extends HomeState {}

class HomeUpdateNote extends HomeState {}

class HomeDeleteNote extends HomeState {}

class HomeDeleteUser extends HomeState {}

class HomeLoading extends HomeState {}
