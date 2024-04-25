import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple, // Couleur de fond de la barre d'appBar
        title: Text('Categories'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Couleur de l'icône
          onPressed: () {
            // Action à exécuter lors du clic sur l'icône de retour
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white), // Couleur de l'icône
            onPressed: () {
              // Action à exécuter lors du clic sur l'icône de panier
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.purple, // Couleur de fond de la section de la barre de recherche
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search, color: Colors.purple), // Couleur de l'icône
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 10), // Ajout d'un espace entre la barre de recherche et la section suivante
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                5,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('../assets/tshirt1.jpg'), // Utilisation de l'image spécifiée
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10), // Ajout d'un espace entre la section précédente et la suivante
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // Désactiver le défilement pour éviter les conflits avec SingleChildScrollView
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 10, // Nombre d'éléments rectangulaires à afficher
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('../assets/tshirt1.jpg'), // Utilisation de l'image spécifiée
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Title $index'),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Action à exécuter lors du clic sur le bouton
                        },
                        child: Text('Button'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
