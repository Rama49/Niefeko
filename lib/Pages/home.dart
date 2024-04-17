import 'package:flutter/material.dart';
import 'package:niefeko/Components/Carte/recherche/recherche.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
    Column(children: [
       search(),
    ],)
    ,);
  }
}