// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:niefeko/Pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = initializeFirebase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static Future<FirebaseApp> initializeFirebase() async {
    return await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBE5tqoygdvXY4uZ8Zq_viDxOa3JSjB3Yc",
        authDomain: "niefeko-4d059.firebaseapp.com",
        projectId: "niefeko-4d059",
        storageBucket: "niefeko-4d059.appspot.com",
        messagingSenderId: "411609193394",
        appId: "1:411609193394:web:f032282e6f062bb18ea2ab",
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MyHomePage(),
    );
  }
}
