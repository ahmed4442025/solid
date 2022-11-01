import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/get_it.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}

