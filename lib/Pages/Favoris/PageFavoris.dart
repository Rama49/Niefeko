import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:niefeko/Components/Recherche/recherche.dart';
//import 'package:niefeko/Pages/Category/CategoriePage.dart';
import 'package:niefeko/Components/Category/product.dart';


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
      // bottomNavigationBar: BottomAppBar(
      //   color: Color(0xFF593070),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => search(),
      //             ),
      //           );
      //         },
      //         icon: Icon(Icons.home, color: Colors.white),
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => search(),
      //             ),
      //           );
      //         },
      //         icon: Icon(Icons.shopping_cart, color: Colors.white),
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //       builder: (context) => pageFavoris(
      //           //           Product(imagePath: "assets/sacoche.png", name: "name", price: 1000): Product(
      //           //               imagePath: "assets/casque.png",
      //           //               name: "rrrrrraaaaama",
      //           //               price: 100))),
      //           // );
      //         },
      //         icon: Icon(Icons.favorite, color: Colors.white),
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => CategoryPage(),
      //             ),
      //           );
      //         },
      //         icon: Icon(Icons.settings, color: Colors.white),
      //       ),
      //     ],
      //   ),
      // ),
    
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

            // Vérifiez si les champs requis sont null, sinon utilisez une valeur par défaut
            String imagePath = data['imagePath'] ?? 'assets/sac1.png';
            String name = data['name'] ?? 'sac';
            String description = data['desciption'];
            double price = data['price'] ?? 10000;
            String idClient = data['idClient'] ?? 'idClient';

            Product product = Product(
              imagePath: imagePath,
              name: name,
              description: description,
              price: price,
              // idClient: idClient,
            );

            return ProductCard(product: product, documentId: document.id);
          }).toList(),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final String documentId;

  const ProductCard({required this.product, required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(product.imagePath),
        title: Text(product.name),
        subtitle: Text('Prix: ${product.price}'),
        trailing: IconButton(
          icon: Icon(Icons.delete), // Icône de suppression
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirmer la suppression'),
                  content: Text('Voulez-vous vraiment supprimer ce produit ?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Annuler'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Fermer la boîte de dialogue
                      },
                    ),
                    TextButton(
                      child: Text('Supprimer'),
                      onPressed: () {
                        // Supprimez le produit de la base de données Firestore en utilisant l'ID du document
                        FirebaseFirestore.instance.collection('favoris').doc(documentId).delete();
                        Navigator.of(context).pop(); // Fermer la boîte de dialogue
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
