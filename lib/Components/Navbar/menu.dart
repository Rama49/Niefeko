import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class MyMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
      ),
      body: const Center(
        child: Text("Contenu de la page"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Colors.blue, // Couleur de l'icône sélectionnée
        unselectedItemColor: Colors.grey, // Couleur de l'icône non sélectionnée
        currentIndex: 0, // Index de l'élément actuellement sélectionné
        onTap: (index) {
          // ignore: avoid_print
          print("Item $index sélectionné");
        },
      ),
    );
  }
}
