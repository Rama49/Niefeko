import 'package:flutter/material.dart';
import 'package:niefeko/Pages/Inscription/inscription.dart';
import 'package:niefeko/Pages/Splash/splash.dart';
import 'package:niefeko/Pages/pageAcceuil/PageAcceuil.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showSplash = true; 

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
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
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: Column(
              children: [
                inscription(),
                pageAcceuil(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
