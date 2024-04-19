import 'package:flutter/material.dart';
import 'package:niefeko/Components/Carte/carte.dart';
import 'package:niefeko/Components/Carte/recherche/recherche.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // First section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: search(),
          ),
          // Second section
          Positioned.fill(
           top: 0/* ajustez la hauteur de la première section */,
            left: 0,
            right: 0,
            bottom: 250,
            child: carte(),
          ),
        ],
      ),
    );
  }
}
