import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:si_mahasiswa/screens/list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: ListScreen(),
    );
  }
}
