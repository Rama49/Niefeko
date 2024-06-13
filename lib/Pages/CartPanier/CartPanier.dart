import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:niefeko/Components/Category/product.dart';

class CartPanier extends StatefulWidget {
  final List<Product> cartItems;

  const CartPanier({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  _CartPanierState createState() => _CartPanierState();
}

class _CartPanierState extends State<CartPanier> {
  double getTotalPrice() {
    double total = 0.0;
    for (var product in widget.cartItems) {
      total += product.price;
    }
    return total;
  }

  // Méthode pour envoyer la commande à l'API
 // Méthode pour envoyer la commande à l'API
  Future<void> sendOrder(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://niefeko.com/wp-json/custom-routes/v1/customer/orders'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'billing': {
            'first_name': '',
            'last_name': '',
            'address_1': '',
            'address_2': '',
            'city': '',
            'state': '',
            'postcode': '',
            'country': '',
            'email': '',
            'phone': ''
          },
          'shipping': {
            'first_name': '',
            'last_name': '',
            'address_1': 't',
            'address_2': '',
            'city': '',
            'state': '',
            'postcode': '',
            'country': ''
          },
          'line_items': widget.cartItems
              .map((product) => {
                    'user_id': product.id,
                    'quantity': 1, // Vous pouvez ajuster la quantité si nécessaire
                  })
              .toList(),
          'shipping_lines': [
            {
              'method_id': '',
              'method_title': '',
              'total': ''
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        // Si la commande a été envoyée avec succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Commande passée avec succès!'),
          ),
        );
      } else {
        // En cas d'erreur de l'API
        throw Exception(
            'Erreur lors de la validation du panier : ${response.reasonPhrase}');
      }
    } catch (error) {
      // En cas d'erreur réseau ou autre
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la validation du panier : $error'),
        ),
      );
    }
  }

  // Méthode pour vider le panier sur l'API
  Future<void> clearCart(BuildContext context) async {
    try {
      final response = await http.delete(
        Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/cart'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Si le panier a été vidé avec succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Panier vidé avec succès!'),
          ),
        );
      } else {
        // En cas d'erreur de l'API
        throw Exception(
            'Erreur lors de la vidange du panier : ${response.reasonPhrase}');
      }
    } catch (error) {
      // En cas d'erreur réseau ou autre
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la vidange du panier : $error'),
        ),
      );
    }
  }

  // Méthode pour supprimer un produit du panier sur l'API
  Future<void> deleteProductFromCart(BuildContext context, Product product) async {
    try {
      final response = await http.delete(
        Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/cart/${product.id}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Si le produit a été supprimé avec succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produit supprimé du panier avec succès!'),
          ),
        );
      } else {
        // En cas d'erreur de l'API
        throw Exception(
            'Erreur lors de la suppression du produit : ${response.reasonPhrase}');
      }
    } catch (error) {
      // En cas d'erreur réseau ou autre
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la suppression du produit : $error'),
        ),
      );
    }
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
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text('Votre panier est vide.'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = widget.cartItems[index];
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            product.imagePath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error);
                            },
                          ),
                          title: Text(product.name),
                          subtitle: Text('${product.price} FCFA'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
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
                                        onPressed: () async {
                                          // Supprimer le produit du panier
                                          await deleteProductFromCart(context, product);
                                          Navigator.of(context).pop();
                                          setState(() {
                                            widget.cartItems.remove(product);
                                          });
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
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Prix total: ${getTotalPrice()} FCFA',
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
                        sendOrder(context);
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
