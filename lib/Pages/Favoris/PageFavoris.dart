import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:niefeko/Components/Recherche/recherche.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

class pageFavoris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF593070),
        title: Text(
          'Détails du produit',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ProductList(),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF593070),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => search(),
                  ),
                );
              },
              icon: Icon(Icons.home, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => search(),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => pageFavoris(
                //           Product(imagePath: "assets/sacoche.png", name: "name", price: 1000): Product(
                //               imagePath: "assets/casque.png",
                //               name: "rrrrrraaaaama",
                //               price: 100))),
                // );
              },
              icon: Icon(Icons.favorite, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(),
                  ),
                );
              },
              icon: Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('favoris').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Une erreur s\'est produite.'));
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Aucun produit trouvé dans les favoris.'));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            Product product = Product(
              imagePath: data['imagePath'],
              name: data['name'],
              price: data['price'],
            );

            return ProductCard(product: product);
          }).toList(),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(product.imagePath),
        title: Text(product.name),
        subtitle: Text('Prix: ${product.price}'),
        // Ajoutez d'autres détails du produit ici selon vos besoins
        // Vous pouvez également ajouter un bouton pour supprimer le produit des favoris
      ),
    );
  }
}
