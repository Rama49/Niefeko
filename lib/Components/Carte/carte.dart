import 'package:flutter/material.dart';

class carte extends StatefulWidget {
  const carte({super.key});

  @override
  State<carte> createState() => _carteState();
}

class _carteState extends State<carte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child:    cartItems.isEmpty
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
                    onPressed: () => validateCart(context),
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
   ));
  }
}