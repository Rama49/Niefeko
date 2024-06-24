import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

class pagefavoris extends StatefulWidget {
  const pagefavoris({super.key});

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
    final response = await http.get(Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/favorits'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        for (var json in responseData) {
          final product = Product(
            imagePath: json['imagePath'] ?? 'assets/sac1.png',
            name: json['name'] ?? 'sac',
            price: double.parse(json['price'] ?? '10000'),
            description: json['description'] ?? '',
          );
          favoriteProducts.add(product);
        }
        isLoading = false;
      });
    } else {
      throw Exception('Échec du chargement des produits favoris');
    }
  }

  void removeFavorite(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/favorits'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': product.hashCode.toString()}),
      );

      if (response.statusCode == 200) {
        setState(() {
          favoriteProducts.remove(product);
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Produit retiré des favoris'),
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
                        leading: Image.network(product.imagePath),
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
                                  content: const Text('Voulez-vous vraiment supprimer ce produit ?'),
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
