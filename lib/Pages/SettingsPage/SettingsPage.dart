import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:niefeko/Pages/Connexion/connexion.dart';
import 'package:niefeko/Pages/ModifierMDP/ModifierMDP.dart';

// ignore: use_key_in_widget_constructors
class SettingsPage extends StatelessWidget {
  // Obtenir l'ID de l'utilisateur actuellement connecté
  String? get userID => FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF612C7D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text(
          'Paramètres',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Inscription')
            .doc(userID) // Utilisation de userID obtenu via Firebase Auth
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Afficher un indicateur de chargement en attendant les données
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            // Si aucun document n'est trouvé pour cet utilisateur, gérer en conséquence
            return const Center(
                child: Text('Aucune donnée trouvée pour cet utilisateur'));
          }

          String? prenom = snapshot.data?.get('prenom');
          String? nom = snapshot.data?.get('nom');
          String? email = snapshot.data?.get('email');

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.person,
                  size: 100.0,
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Prénom: $prenom',
                        style: const TextStyle(color: Colors.white, fontSize: 20)),
                    Text('Nom: $nom',
                        style: const TextStyle(color: Colors.white, fontSize: 20)),
                    Text('Email: $email',
                        style: const TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 18, right: 16, left: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: const Color(0xFF612C7D)),
                  ),
                  child: ListTile(
                    title: const Text('Modifier le mot de passe',
                        style: TextStyle(color: Color(0xFF612C7D))),
                    onTap: () {
                      // Naviguer vers l'écran de modification du mot de passe
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ModifierMDP()),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20, right: 16, left: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF612C7D),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.white),
                  ),
                  child: ListTile(
                    title: const Text('Déconnexion',
                        style: TextStyle(color: Colors.white)),
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
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Connexion()),
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
