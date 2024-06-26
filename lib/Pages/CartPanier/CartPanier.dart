import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:niefeko/Components/Category/product.dart';

class CartPanier extends StatefulWidget {
  final List<Product> cartItems;
  final String user_firstname;
  final String user_lastname;
  final String user_email;

  const CartPanier({
    Key? key,
    required this.cartItems,
    required this.user_firstname,
    required this.user_lastname,
    required this.user_email,
  }) : super(key: key);

  @override
  _CartPanierState createState() => _CartPanierState();
}

class _CartPanierState extends State<CartPanier> {
  String getCurrentUserId() {
    // Ici, vous devriez avoir une méthode pour récupérer l'ID de l'utilisateur connecté
    // Cette méthode dépend de votre logique d'authentification
    return "userID"; // Remplacez ceci par la méthode réelle pour obtenir l'ID de l'utilisateur
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var product in widget.cartItems) {
      total += product.price * product.quantity;
    }
    return total;
  }

  Future<void> sendOrder(BuildContext context) async {
    try {
      String userId = getCurrentUserId();

      final response = await http.post(
        Uri.parse(
            'https://niefeko.com/wp-json/custom-routes/v1/customer/orders'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'billing': {
            'user_id': userId,
            'first_name': widget.user_firstname,
            'last_name': widget.user_lastname,
            'address_1': 'Default Address 1',
            'address_2': 'Default Address 2',
            'city': 'Default City',
            'state': 'Default State',
            'postcode': '00000',
            'country': 'Default Country',
            'email': widget.user_email,
            'phone': '0000000000'
          },
          'shipping': {
            'user_id': userId,
            'first_name': widget.user_firstname,
            'last_name': widget.user_lastname,
            'address_1': 'Default Address 1',
            'address_2': 'Default Address 2',
            'city': 'Default City',
            'state': 'Default State',
            'postcode': '00000',
            'country': 'Default Country'
          },
          'line_items': widget.cartItems
              .map((product) => {
                    'product_id': product.id,
                    'quantity': product.quantity,
                  })
              .toList(),
          'shipping_lines': [
            {
              'method_id': 'flat_rate',
              'method_title': 'Flat Rate',
              'total': '10.00'
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Commande passée avec succès!'),
          ),
        );
      } else {
        throw Exception(
            'Erreur lors de la validation du panier : ${response.reasonPhrase}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la validation du panier : $error'),
        ),
      );
    }
  }

  void increaseQuantity(Product product) {
    setState(() {
      product.quantity++;
    });
  }

  void decreaseQuantity(Product product) {
    setState(() {
      if (product.quantity > 1) {
        product.quantity--;
      }
    });
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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  decreaseQuantity(product);
                                },
                              ),
                              Text(product.quantity.toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  increaseQuantity(product);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
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
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Supprimer'),
                                            onPressed: () {
                                              setState(() {
                                                widget.cartItems.remove(product);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
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