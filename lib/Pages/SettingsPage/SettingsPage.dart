import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:niefeko/Pages/Connexion/conexion.dart'; // Importez la page de connexion
import 'package:niefeko/Pages/ModifierMDP/ModifierMDP.dart';
import 'package:niefeko/utils/auth.dart';

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
        title: const Text('Paramètres'),
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
                print('Déconnexion réussie');
                // Afficher un message de déconnexion réussie dans l'application
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Déconnexion réussie'),
                    duration: Duration(seconds: 2),
                  ),
                );
                // Naviguer vers la page de connexion
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const connexion()),
                );
              } catch (error) {
                // Afficher un message d'erreur en cas de problème de déconnexion
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