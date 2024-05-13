// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';
import 'package:niefeko/Components/Category/product.dart';


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
                      return Card(
                        child: ListTile(
                          leading: Image.asset(
                            product.imagePath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.name),
                          subtitle: Text('\$${product.price}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              removeFromCart(index);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Produit supprimé du panier'),
                              ));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () => validateCart(context),
                    style: ElevatedButton.styleFrom(
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Valider le panier',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                      //  primary: Colors.green,
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
