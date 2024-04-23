import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF612C7D),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Flexible(child: Image.asset(
                  "../../assets/logoNiefeko.png",
                  width: 200,
                  color: Colors.white,
                ),),
            ),
             
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
