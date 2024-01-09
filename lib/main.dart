import 'package:flutter/material.dart';
import 'package:todo_tracker/activites/drawer_connection.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_tracker/activites/splash_screen.dart';

void main() async {
  // init hive
  // await Hive.initFlutter();
  // var box = await Hive.openBox('mybox');
  // open a hive box

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDO task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DrawerConnection(),
    );
  }
}
