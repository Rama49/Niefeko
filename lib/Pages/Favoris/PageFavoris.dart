// Pages/Favoris/PageFavoris.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:niefeko/Components/Recherche/recherche.dart';
//import 'package:niefeko/Pages/Category/CategoriePage.dart';
import 'package:niefeko/Components/Category/product.dart';


// ignore: camel_case_types
class pagefavoris extends StatelessWidget {
  const pagefavoris({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF593070),
        title: const Text(
          'Produits favoris',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ProductList(),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('favoris').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Une erreur s\'est produite.'));
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text('Aucun produit trouvé dans les favoris.'));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            String imagePath = data['imagePath'] ?? 'assets/sac1.png';
            String name = data['name'] ?? 'sac';
            String description = data['desciption']?? 'Description du produit';
            double price = data['price'] ?? 10000;
            String idClient = data['idClient'] ?? 'idClient';

            Product product = Product(
              imagePath: imagePath,
              name: name,
              description: description,
              price: price,
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

  const ProductCard({super.key, required this.product, required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(product.imagePath),
        title: Text(product.name),
        subtitle: Text('Prix: ${product.price}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red,),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirmer la suppression'),
                  content:
                      const Text('Voulez-vous vraiment supprimer ce produit ?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Annuler'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Supprimer'),
                      onPressed: () {
                        FirebaseFirestore.instance
                          .collection('favoris')
                          .doc(documentId)
                          .delete();
                        Navigator.of(context).pop();
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
