// Pages/Splash/splash.dart

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF612C7D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Image.asset(
                "assets/logoNiefeko.png", // Update the path to your image asset
                width: 200,
                color: Colors.white,
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
