import 'package:flutter/material.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart'; // Importez les classes nécessaires depuis le fichier de catégorie

class CartPanier extends StatelessWidget {
  final List<Product> cartItems;
  final Function(int) removeFromCart;
  final String idClient;
  final String prenom;
  final String nom;
  final String email;
  final Function(BuildContext context, String, String, String) validateCart; // Modifier le type de validateCart

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: cartItems.isEmpty
          ? Center(
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
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              removeFromCart(index);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                    onPressed: () {
                      validateCart(context, idClient, prenom, nom); // Appel de validateCart avec les arguments requis
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Panier validé'),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Valider le panier',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
