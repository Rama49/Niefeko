import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:niefeko/Components/Category/CategorieHeader.dart';
import 'package:niefeko/Pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Déclaration de la future pour l'initialisation de Firebase
  final Future<FirebaseApp> _initialization = initializeFirebase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Utilisation de la future pour initialiser FlutterFire
      future: _initialization,
      builder: (context, snapshot) {
        // Vérification des erreurs
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }

        // Une fois l'initialisation terminée, affichez votre application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Sinon, affichez un indicateur de chargement
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Fonction pour initialiser Firebase
  static Future<FirebaseApp> initializeFirebase() async {
    // Vérifiez d'abord si l'application s'exécute sur le web
    return await Firebase.initializeApp(
      options: FirebaseOptions(
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
      home: const MyHomePage(),
      routes: {
        '/CategorieHeader': (context) =>
            CategorieHeader(), // Route pour la page "Catégorie"
      },
    );
  }
}
