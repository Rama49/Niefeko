import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:niefeko/Pages/Connexion/connexion.dart';
// ignore: unused_import
import 'package:niefeko/Pages/Inscription/inscription.dart';
import 'package:niefeko/Pages/Recherche/recherche.dart';
import 'package:niefeko/Pages/Splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

// ignore: use_key_in_widget_constructors
class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = initializeFirebase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MyHomePage();
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

// ignore: use_key_in_widget_constructors
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
            child: _showSplash
                ? const SizedBox.shrink()
                : const connexion(),
          ),
        ],
      ),
    );
  }
}
