import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:solid/controllers/home_cubit.dart';
import 'package:solid/data/data_source/database/db_factory.dart';
import 'package:solid/data/data_source/network/dio_factory.dart';
import 'package:solid/data/repository/control_repo.dart';
import 'package:solid/data/repository/data/asset_repository.dart';
import 'package:solid/data/repository/data/database_repo.dart';
import 'package:solid/data/repository/data/network_repo.dart';
import 'package:sqflite/sqflite.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // asset
  instance.registerLazySingleton<AssetRepository>(() => AssetRepository());
  // network
  Dio dio = await DioFactory().getDio();
  instance.registerLazySingleton<NetworkRepo>(() => NetworkRepo(dio));
  // DB
  instance.registerLazySingleton<DBFactory>(() => DBFactory());
  Database db = await instance<DBFactory>().getDB();
  instance.registerLazySingleton<DatabaseRepo>(() => DatabaseRepo(db));
  // db controller
  instance.registerLazySingleton<DataBaseControl>(() => DataBaseControl(db));

  // cubits
  instance.registerLazySingleton<HomeCubit>(
      () => HomeCubit(instance<DatabaseRepo>(), instance<DataBaseControl>()));
  await instance<HomeCubit>().init();
}
