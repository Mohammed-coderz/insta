import 'package:flutter/material.dart';
import 'package:untitled7/screens/grid_view_builder_screen.dart';
import 'package:untitled7/screens/home_screen.dart';
import 'package:untitled7/screens/image.dart';
import 'package:untitled7/screens/list_view_builder_screen.dart';
import 'package:untitled7/screens/list_view_screen.dart';
import 'package:untitled7/screens/login_screen.dart';
import 'screens/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: Images(),
    );
  }
}

