// Pages/SettingsPage/SettingsPage.dart
import 'package:flutter/material.dart';import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:niefeko/Pages/Connexion/connexion.dart';
import 'package:niefeko/Pages/ModifierMDP/ModifierMDP.dart';
import 'package:niefeko/utils/auth.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!AuthState.isLoggedIn()) {
      return const Connexion();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Modifier le mot de passe'),
            onTap: () {
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
                await FirebaseAuth.instance.signOut();
                print('Déconnexion réussie');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Déconnexion réussie'),
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Connexion()),
                );
              } catch (error) {
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
