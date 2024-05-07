import 'package:flutter/material.dart';

class MyMenu extends StatelessWidget {
  const MyMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
      ),
      body: Center(
        child: const Text("Contenu de la page"),
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
          print("Item $index sélectionné");
        },
      ),
    );
  }
}
