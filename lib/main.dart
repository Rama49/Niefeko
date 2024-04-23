import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:niefeko/Components/Category/CategorieHeader.dart';
import 'package:niefeko/Pages/home.dart';
import 'package:niefeko/Reutilisable/carteReu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Vérifiez d'abord si l'application s'exécute sur le web
  if (kIsWeb) {
    await Firebase.initializeApp(
      name: 'niefeko-4d059',
      options: const FirebaseOptions(
        apiKey: "AIzaSyBE5tqoygdvXY4uZ8Zq_viDxOa3JSjB3Yc",
        authDomain: "niefeko-4d059.firebaseapp.com",
        projectId: "niefeko-4d059",
        storageBucket: "niefeko-4d059.appspot.com",
        messagingSenderId: "411609193394",
        appId: "1:411609193394:web:f032282e6f062bb18ea2ab",
      ),
    );
  } else {
    // Si ce n'est pas le web, initialisez Firebase sans options
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: {
        '/CategorieHeader': (context) => CategorieHeader(), // Route pour la page "Catégorie"
      },
    );
  }
}
