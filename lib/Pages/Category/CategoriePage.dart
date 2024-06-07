import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/Recherche/recherche.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Map<int, Product> products;
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    products = {};
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://niefeko.com/wp-json/dokan/v1/stores/16/products'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        for (var json in responseData) {
          final product = Product(
            imagePath: json['images'][0]['src'] ?? '',
            name: json['name'] ?? '',
            description: json['description'] ?? '',
            price: double.parse(json['price'] ?? '0.0'),
          );
          products[json['id']] = product;
        }
        filteredProducts = products.values.toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  void searchProduct(String query) {
    final results = products.values
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Produits', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              // Ajoutez ici la logique pour naviguer vers le panier
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.black),
              onChanged: searchProduct,
            ),
          ),
        ),
      ),
      body: filteredProducts.isEmpty
          ? Center(
              child: Text(
                'Produit non trouvé',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.network(
                              product.imagePath,
                              height: 130,
                              width: 130,
                            ),
                          ),
                          SizedBox(height: 8),
                          Center(
                            child: Text(
                              product.name,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          Html(
                            data: product.description,
                          ),
                          SizedBox(height: 8),
                          Center(
                            child: Text(
                              '${product.price} FCFA',
                              style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Ajouter la logique pour ajouter au panier
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF612C7D),
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: const BorderSide(color: Color(0xFF612C7D)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Ajouter au panier",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(Icons.shopping_cart, color: Colors.white), // Icône de panier
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
