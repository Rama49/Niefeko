import 'package:flutter/material.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

class CartSummary extends StatelessWidget {
  final List<Product> cartItems;
  final Function(BuildContext) validateCart;

  const CartSummary({
    Key? key,
    required this.cartItems,
    required this.validateCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      totalPrice += item.price;
    }

    return Column(
      children: [
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
    );
  }
}
