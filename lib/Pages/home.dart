// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:niefeko/Pages/Connexion/conexion.dart';
// ignore: unused_import
import 'package:niefeko/Pages/Inscription/inscription.dart';
import 'package:niefeko/Pages/Splash/splash.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_showSplash) SplashScreen(),
          AnimatedOpacity(
            opacity: _showSplash ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            // ignore: avoid_unnecessary_containers
            child: _showSplash ? const SizedBox.shrink() : Container(
              child: 
                const connexion(),
            ),
          ),
        ],
      ),
    );
  }
}
