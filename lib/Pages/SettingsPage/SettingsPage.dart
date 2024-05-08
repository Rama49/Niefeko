// Pages/SettingsPage/SettingsPage.dart
// ignore_for_file: file_names// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:niefeko/Pages/Connexion/connexion.dart';
import 'package:niefeko/Pages/ModifierMDP/ModifierMDP.dart';
import 'package:niefeko/utils/auth.dart';

// ignore: use_key_in_widget_constructors
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Vérifiez si l'utilisateur est connecté avant de lui permettre d'accéder à la page des paramètres
    if (!AuthState.isLoggedIn()) {
      // Si l'utilisateur n'est pas connecté, redirigez-le vers la page de connexion
      return const connexion();
    }

    // Si l'utilisateur est connecté, affichez la page des paramètres
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text(
          'Paramètres',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Modifier le mot de passe'),
            onTap: () {
              // Naviguer vers l'écran de modification du mot de passe
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModifierMDP()),
              );
            },
          ),
          ListTile(
            title: const Text('Déconnexion'),
            onTap: () async {
              try {
                // Déconnexion de l'utilisateur
                await FirebaseAuth.instance.signOut();
                // Afficher un message de déconnexion réussie dans le terminal
                // ignore: avoid_print
                print('Déconnexion réussie');
                // Afficher un message de déconnexion réussie dans l'application
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Déconnexion réussie'),
                    duration: Duration(seconds: 2),
                  ),
                );
                // Naviguer vers la page de connexion
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const connexion()),
                );
              } catch (error) {
                // Afficher un message d'erreur en cas de problème de déconnexion
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Erreur lors de la déconnexion'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}