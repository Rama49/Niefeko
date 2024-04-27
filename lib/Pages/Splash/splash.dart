
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF612C7D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Image.asset(
                "../../assets/logoNiefeko.png", // Update the path to your image asset
                width: 200,
                color: Colors.white,
              ),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
