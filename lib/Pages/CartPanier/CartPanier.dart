import 'package:flutter/material.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

class CartPanier extends StatelessWidget {
  final List<Product> cartItems;
  final Function(int) removeFromCart;

  const CartPanier({
    Key? key,
    required this.cartItems,
    required this.removeFromCart,
  }) : super(key: key);

  void validateCart(BuildContext context) {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      totalPrice += item.price;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Total Price'),
        content: Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

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
              ],
            ),
    );
  }
}
