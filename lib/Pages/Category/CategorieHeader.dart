import 'package:flutter/material.dart';

class CategorieHeader extends StatelessWidget {
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
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirt1.jpg',
  ];

  CategorieHeader({Key? key}) : super(key: key);

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

class CategorieBody extends StatelessWidget {
  final List<String> imageUrls;

  CategorieBody({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green, // Couleur verte pour le fond du body
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Affichage en mode portrait sur mobile
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: imageUrls.map((imageUrl) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildStory(imageUrl),
                  );
                }).toList(),
              ),
            );
          } else {
            // Affichage en mode paysage sur tablette
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: imageUrls.map((imageUrl) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildStory(imageUrl),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildStory(String imageUrl) {
    return Container(
      width: 150, // Largeur de la carte d'image
      height: 150, // Hauteur de la carte d'image
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
            child: Image.asset(
              imageUrl,
              width: 100, // Largeur de l'image
              height: 100, // Hauteur de l'image
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tee-shirt', // Titre
            style: TextStyle(
              color: Colors.white, // Couleur du texte
              fontSize: 16, // Taille de la police
              fontWeight: FontWeight.bold, // Gras
            ),
          ),
        ],
      ),
    );
  }
}
