import 'package:flutter/material.dart';
import 'package:niefeko/Components/Recherche/recherche.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 77, 70, 81),
        title: Text('Détails du produit', style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Nom du produit: ${product.name}'),
              Text('Prix: ${product.price}'),
              // Afficher d'autres détails du produit ici selon vos besoins
            ],
          ),
        ),
      
      ),
        bottomNavigationBar: BottomAppBar(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(40.0),
          //     topRight: Radius.circular(40.0),
          //   ),

          color: Color(0xFF593070),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => search(),
                    ),
                  );
                },
                icon: Icon(Icons.home, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                      Navigator.push(
  context,
   MaterialPageRoute(
                                builder: (context) => search(),

                  ),
);

                },
                icon: Icon(Icons.shopping_cart, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                     MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: Product(imagePath: "assets/casque.png", name: "rrrrrraaaaama", price: 100))
          ),
                  );
                },
                icon: Icon(Icons.favorite, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(),
                    ),
                  );
                },
                icon: Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),
        ));
  
    
  }
}
