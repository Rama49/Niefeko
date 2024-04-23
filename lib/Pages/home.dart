import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }
}