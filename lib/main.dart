import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const MyApp());
}



