import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technical_task_assignment_2/utils/routes/route.dart';
import 'package:technical_task_assignment_2/utils/routes/route_name.dart';


import 'bindings/bindings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Technical Task Assignment Two',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
      initialBinding: ControllerBinders(),
    );
  }
}