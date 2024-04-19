import 'package:flutter/material.dart';
import 'package:niefeko/Components/Carte/carte.dart';
import 'package:niefeko/Components/Carte/recherche/recherche.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
              child: Column(
        children: [
          search(),
          carte(),
          search()
        ],
      ))),
    );
  }
}
