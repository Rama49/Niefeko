import 'package:flutter/material.dart';

class CategorieBody extends StatelessWidget {
  const CategorieBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy product data
    List<Map<String, dynamic>> products = List.generate(
      8,
      (index) => {
        'imageUrl': 'https://via.placeholder.com/150',
        'productName': 'Product $index',
        'price': 20.0,
      },
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine le nombre de colonnes en fonction de la largeur de l'écran
        int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Product image
                    Image.network(
                      product['imageUrl'],
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    // Heart icon in top right corner
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                    // Product name
                    Text(
                      product['productName'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Product price
                    Text(
                      '\$${product['price']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Buy button
                    ElevatedButton(
                      onPressed: () {
                        // Action when buy button is pressed
                      },
                      child: Text('Acheter'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
