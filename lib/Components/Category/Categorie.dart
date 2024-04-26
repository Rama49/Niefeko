import 'package:flutter/material.dart';

class Categorie extends StatelessWidget {
  final List<String> imageUrls = [
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
  ];

  Categorie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Couleur verte de la barre d'en-tête
        iconTheme: IconThemeData(color: Colors.white), // Couleur blanche pour les icônes
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Gérer l'action du panier ici
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70), // Hauteur de la barre de recherche avec marge supérieure
          child: Center( // Centrer la barre de recherche
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), // Ajout de la marge supérieure
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Couleur de fond blanche
                        borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
                        border: Border.all(color: Colors.grey), // Bordure grise
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Ajouter un peu de marge horizontale
                        child: TextField(
                          style: TextStyle(color: Colors.black), // Couleur du texte entré en noir
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.grey), // Icône de recherche en gris
                            hintText: 'Rechercher un produit', // Texte placeholder
                            hintStyle: TextStyle(color: Colors.grey), // Couleur du texte placeholder en gris
                            border: InputBorder.none, // Supprimer la bordure
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // body: CategorieBody(imageUrls: imageUrls),
    );
  }
}