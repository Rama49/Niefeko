import 'package:flutter/material.dart';
import 'package:niefeko/Pages/home.dart';
import 'package:niefeko/Reutilisable/carteReu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
       home: MyHomePage(),
    );
  }
}

