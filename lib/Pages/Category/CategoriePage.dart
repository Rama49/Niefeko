import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart'; // Importez flutter_html
import 'package:niefeko/Components/Category/product.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Map<int, Product> products;

  @override
  void initState() {
    super.initState();
    products = {}; // Initialiser la map des produits
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
          products[json['id']] = product; // Utiliser l'ID comme clé
        }
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D), // Couleur personnalisée pour l'AppBar
        iconTheme: IconThemeData(color: Colors.white), // Couleur blanche pour l'icône de retour
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back), // Ajouter l'icône de retour
            onPressed: () {
              // Ajoutez ici la logique pour revenir en arrière
            },
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
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
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart), // Ajouter l'icône du panier
            onPressed: () {
              // Ajoutez ici la logique pour naviguer vers le panier
            },
          ),
        ],
      ),
      body: products.isEmpty // Vérifier si la liste des produits est vide
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products.values.toList()[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Html(
                    data: product.description,
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.imagePath),
                  ),
                  trailing: Text('${product.price} €'),
                  onTap: () {
                    // TODO: Add navigation to product details
                  },
                );
              },
            ),
    );
  }
}
