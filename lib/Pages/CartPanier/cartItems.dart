import 'package:flutter/material.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

class CartItemList extends StatelessWidget {
  final List<Product> cartItems;
  final Function(int) removeFromCart;

  const CartItemList({
    Key? key,
    required this.cartItems,
    required this.removeFromCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
