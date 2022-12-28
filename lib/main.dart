import 'package:flutter/material.dart';
import 'package:sql_app/Editnote.dart';
import 'package:sql_app/Home.dart';

import 'AddNotes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homeos(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      routes: {
        Addnotes.ScreenRoute: (context) => Addnotes(),
        Homeos.ScreenRoute: (context) => Homeos(),
        EditNotes.ScreenRoute: (context) => EditNotes()
      },
    );
  }
}
