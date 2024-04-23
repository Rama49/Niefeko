import 'package:flutter/material.dart';
import 'package:niefeko/Pages/Connexion/conexion.dart';
import 'package:niefeko/Pages/Inscription/inscription.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       body: Column(children: [conexion() 
      
                ],
       )
      );
  }
}