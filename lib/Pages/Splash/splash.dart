// Pages/Splash/splash.dart
import 'package:flutter/material.dart';import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // ou TextDirection.rtl selon votre langue
      child: Scaffold(
        backgroundColor: const Color(0xFF612C7D),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Image.asset(
                  "../assets/logoNiefeko.png", // Updated the path to your image asset
                  width: 200,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
