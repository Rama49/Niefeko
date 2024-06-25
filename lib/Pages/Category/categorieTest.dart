import 'package:flutter/material.dart';
import 'package:niefeko/Components/Category/product.dart';

class Test extends StatefulWidget {
  final Function(Product) addToCart;
  final Function() onDecrementSearchIcon;

  const Test(
      {Key? key, 
      required this.addToCart, 
      required this.onDecrementSearchIcon})
      : super(key: key);

  @override
  State<Test> createState() => _TextState();
}

class _TextState extends State<Test> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (!isExpanded) {
            // Créez un produit fictif pour tester
            Product product = Product(
               id:0,
              imagePath: 'assets/votre_image.png',
              name: 'Nom du produit',
              description: 'Description du produit',
              price: 10.0,
              quantity: 1,
            );
            // Appelez la fonction de rappel pour ajouter le produit au panier
            widget.addToCart(product);
          } else {
            // Si le bouton est déjà étendu, appelez la fonction de décrémentation de l'icône de recherche
            widget.onDecrementSearchIcon();
          }
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          width: isExpanded ? 200 : 80.0,
          height: 50.0,
          decoration: BoxDecoration(
              color: isExpanded
                  ? Color.fromARGB(255, 215, 194, 233)
                  : Color.fromARGB(255, 72, 26, 97),
              borderRadius: BorderRadius.circular(isExpanded ? 30 : 10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isExpanded ? Icons.check : Icons.shopping_cart,
                color: isExpanded
                    ? Color.fromARGB(255, 72, 26, 97)
                    : Color.fromARGB(255, 215, 194, 233),
              ),
              Text(
                isExpanded ? "Ajouté au panier" : "",
                style: TextStyle(
                  color: isExpanded
                      ? Color.fromARGB(255, 72, 26, 97)
                      : Color.fromARGB(255, 215, 194, 233),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
