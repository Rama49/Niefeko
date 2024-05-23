import 'package:flutter/material.dart';
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
    Key? key,
    required this.cartItems,
    required this.removeFromCart,
    required this.idClient,
    required this.prenom,
    required this.nom,
    required this.email,
    required this.validateCart,
  }) : super(key: key);

  // Méthode pour calculer le prix total
  double getTotalPrice() {
    double total = 0.0;
    for (var product in cartItems) {
      total += product.price;
    }
    return total;
  }

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
                          subtitle: Text('${product.price} cfa'),
                          trailing: IconButton(
<<<<<<< HEAD
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              removeFromCart(index);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Produit supprimé du panier'),
                              ));
=======
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Afficher la boîte de dialogue de confirmation
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmer la suppression'),
                                    content: const Text('Voulez-vous vraiment supprimer ce produit ?'),
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
                                          // Supprimer le produit du panier
                                          removeFromCart(index);
                                          // Fermer la boîte de dialogue
                                          Navigator.of(context).pop();
                                          // Afficher un message de confirmation
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Produit supprimé du panier'),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
>>>>>>> 1079f3db9f48e576bda93a788b81c25c376cd651
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Afficher le prix total
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Prix total: ${getTotalPrice()} cfa',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        validateCart(context, idClient, prenom, nom);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Panier validé'),
                          ),
                        );
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
