import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:niefeko/Components/Category/product.dart';

class CartPanier extends StatelessWidget {
  final List<Product> cartItems;

  const CartPanier({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  // Méthode pour calculer le prix total
  double getTotalPrice() {
    double total = 0.0;
    for (var product in cartItems) {
      total += product.price;
    }
    return total;
  }

  // Méthode pour envoyer la commande à l'API
  Future<void> sendOrder(BuildContext context) async {
    // Préparez les données de la commande
    final orderData = {
      'products': cartItems
          .map((product) => {
                'id': product.id,
                'quantity': 1, // Vous pouvez ajuster la quantité si nécessaire
              })
          .toList(),
      // Ajoutez d'autres informations nécessaires pour la commande
    };

    try {
      final response = await http.post(
        Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/orders'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orderData),
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
        throw Exception('Erreur lors de la validation du panier : ${response.reasonPhrase}');
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
                          leading: Image.network(
                            product.imagePath, // Utilisation de Image.network
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error); // Affichage d'une icône d'erreur si l'image ne se charge pas
                            },
                          ),
                          title: Text(product.name),
                          subtitle: Text('${product.price} FCFA'),
                          trailing: IconButton(
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
                                          Navigator.of(context).pop();
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
