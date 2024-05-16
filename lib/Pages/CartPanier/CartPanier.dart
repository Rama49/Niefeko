// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
//import 'package:niefeko/Components/Category/detail.dart';
import 'package:niefeko/Components/Category/product.dart';
//import 'package:niefeko/Pages/Category/CategoriePage.dart'; // Importez les classes nécessaires depuis le fichier de catégorie

class CartPanier extends StatelessWidget {
  final List<Product> cartItems;
  final Function(int) removeFromCart;
  final String idClient;
  final String prenom;
  final String nom;
  final String email;
  final Function(BuildContext context, String, String, String) validateCart;

  const CartPanier({
    super.key,
    required this.cartItems,
    required this.removeFromCart,
    required this.idClient,
    required this.prenom,
    required this.nom,
    required this.email,
    required this.validateCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text(
          'Panier',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Votre panier est vide.'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return 
                      GestureDetector(
  onTap: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Product(imagePath: imagePath, name: name, price: price)),
      // );
  },
                    child: Card(
                        child: ListTile(
                          leading: Image.asset(
                            product.imagePath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.name),
                          subtitle: Text('${product.price}cfa'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red,),
                            onPressed: () {
                              removeFromCart(index);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Produit supprimé du panier'),
                              ));
                            },
                          ),
                        ),
                      ));

                    },
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        validateCart(context, idClient, prenom, nom);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Panier validé'),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF612C7D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Valider le panier',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}