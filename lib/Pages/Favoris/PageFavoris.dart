// Pages/Favoris/PageFavoris.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:niefeko/Components/Category/product.dart';
// ignore: unused_import
import 'package:niefeko/Pages/Category/CategoriePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: camel_case_types
class pagefavoris extends StatelessWidget {
  const pagefavoris({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF593070),
        title: const Text(
          'Mes favoris',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const ProductList(),
    );
  }
}
class ProductList extends StatelessWidget {
  // ignore: use_super_parameters
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Gérer le cas où l'utilisateur n'est pas connecté
      return const Center(
        child: Text('Veuillez vous connecter pour voir vos favoris.'),
      );
    }

    String userID = user.uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('favoris')
          .where('userID', isEqualTo: userID)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          // ignore: avoid_print
          print('Erreur lors de la récupération des favoris: ${snapshot.error}');
          return const Center(child: Text('Une erreur s\'est produite.'));
        }

        final docs = snapshot.data!.docs;
        // ignore: avoid_print
        print('Nombre de favoris récupérés: ${docs.length}'); // Débogage
        if (snapshot.data!.docs.isEmpty) {
          // ignore: avoid_print
          print('Aucun produit trouvé dans les favoris.');
          return const Center(
            child: Text('Aucun produit trouvé dans les favoris.'),
          );
        }

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = docs[index].data() as Map<String, dynamic>;

            String imagePath = data['imagePath'];
            String name = data['name'];
            double price = (data['price'] ?? 0).toDouble();

            Product product = Product(
              imagePath: imagePath,
              name: name,
              price: price,
              description: '',
            );

            return ProductCard(product: product, documentId: docs[index].id);
          },
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