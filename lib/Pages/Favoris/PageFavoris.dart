import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:niefeko/Components/Category/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<_pagefavorisState> pagefavorisKey = GlobalKey<_pagefavorisState>();

class pagefavoris extends StatefulWidget {
  @override
  _pagefavorisState createState() => _pagefavorisState();
}

class _pagefavorisState extends State<pagefavoris> {
  List<Product> favoriteProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFavoriteProducts();
  }

  Future<void> fetchFavoriteProducts() async {
    final url = Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/favorits');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        setState(() {
          favoriteProducts = responseData.map((json) => Product(
            id: json['id'],
            imagePath: json['featured_image']['url'] ?? 'assets/images/default_image.png', // Image de secours
            name: json['name'] ?? 'Unknown',
            price: double.parse(json['price'].toString() ?? '0.0'),
            description: json['description'] ?? '',
          )).toList();
          isLoading = false;
        });

        print('API response status code: ${response.statusCode}');
        print('API response body: ${response.body}');
        print('Response data: $responseData');
      } else {
        throw Exception('Échec du chargement des produits favoris');
      }
    } catch (e) {
      print('Erreur lors de la récupération des favoris: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Échec du chargement des produits favoris.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> removeFavorite(Product product) async {
    final url = Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/favorits');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'id': product.id}),
      );

      if (response.statusCode == 200) {
        setState(() {
          favoriteProducts.remove(product);
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Retiré des favoris'),
              content: Text('${product.name} a été retiré de vos favoris.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Échec de la suppression du produit favori');
      }
    } catch (e) {
      print('Erreur lors de la suppression du produit favori: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Échec de la suppression du produit favori.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF593070),
        title: const Text(
          'Produits favoris',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : favoriteProducts.isEmpty
              ? Center(child: Text('Aucun produit trouvé dans les favoris.'))
              : ListView.builder(
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    return Card(
                      child: ListTile(
                        leading: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            product.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(product.name),
                        subtitle: Text('Prix: ${product.price} FCFA'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirmer la suppression'),
                                  content: const Text('Êtes-vous sûr de vouloir supprimer ce produit?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Annuler'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Supprimer'),
                                      onPressed: () {
                                        removeFavorite(product);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
