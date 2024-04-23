import 'package:flutter/material.dart';

class conexion extends StatefulWidget {
  const conexion({super.key});

  @override
  State<conexion> createState() => _conexionState();
}

class _conexionState extends State<conexion> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
      );
  }
}