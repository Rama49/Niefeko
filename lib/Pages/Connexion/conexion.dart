import 'package:flutter/material.dart';

class conexion extends StatefulWidget {
  const conexion({super.key});

  @override
  State<conexion> createState() => _conexionState();
}

class _conexionState extends State<conexion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 150.0,
      //width: 200.0,
      padding: const EdgeInsets.only(top: 100),
      color: const Color.fromARGB(181, 124, 8, 87),
        child: Column(
          children: [
          
          Image.asset("logoNiefeko.png", width: 100, height: 100,),
          
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email', fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16,),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Mot de Passe',fillColor: Colors.white
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Connexion'),
          ),
        ],)
      );
  }
}