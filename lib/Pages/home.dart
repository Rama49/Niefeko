import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:niefeko/Components/Carte/carte.dart';
import 'package:niefeko/Components/Carte/recherche/recherche.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:niefeko/Pages/Inscription/inscription.dart';
>>>>>>> 9e9c4a9d7b32e8825bd1b20fbe3581f22668eb9d

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        title: const Text('Page dec connexion'),
      ),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Mot de Passe',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Login'),
          ),
        ],
      ),
    );
=======
       body: Column(children: [inscription()],)
       //Stack(
      //   children: [
          
      //     search(),
      //   ],
      );
   
>>>>>>> 9e9c4a9d7b32e8825bd1b20fbe3581f22668eb9d
  }
}