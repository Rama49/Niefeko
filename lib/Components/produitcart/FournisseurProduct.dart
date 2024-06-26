import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
import 'package:niefeko/Pages/Category/DetailFournisseur.dart';
import 'package:niefeko/Pages/Recherche/recherche.dart';


class FournisseurProduct extends StatefulWidget {
  final int supplierId;
  final String storeName;

  FournisseurProduct({required this.supplierId, required this.storeName});

  @override
  _FournisseurProductState createState() => _FournisseurProductState();
}

class _FournisseurProductState extends State<FournisseurProduct> {
  List<Product> supplier = [];
  late Map<int, Product> products;
  List<Product> filteredProducts = [];
  List<Product> cartItems =  []; // Liste pour stocker les produits ajoutés au panier
  bool isLoading = true;
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    products = {};
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://niefeko.com/wp-json/dokan/v1/stores/${widget.supplierId}/products'));

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
        isLoading = false;
      });
    } else {
      throw Exception('Échec du chargement des produits');
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

  void addToCart(Product product) {
    setState(() {
      cartItems.add(
          product); // Ajouter le produit à la liste des produits ajoutés au panier
      cartItemCount = cartItems
          .length; // M>ettre à jour le nombre d'articles dans le panier
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Produit ajouté au panier'),
          content: Text('${product.name} a été ajouté à votre panier.'),
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

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPanier(
            cartItems: cartItems,
            user_firstname: "user_firstname",
            user_lastname: "user_lastname",
            user_email: "user_email"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        iconTheme: IconThemeData(color: Colors.white),
        title:  Text('Produits de ${widget.storeName}', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            //Navigator.pop(context);
            Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => search(),));
          },
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed:
                    openCart, // Ouvrir le panier avec les produits ajoutés
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    cartItemCount
                        .toString(), // Afficher le nombre de produits dans le panier
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : filteredProducts.isEmpty
              ? Center(
                  child: Text(
                    'Pas de produit pour l\'instant',
                    style: TextStyle(color: Color(0xFF612C7D), fontSize: 18),
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
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailFournisseur(product: product, productId: supplier.toString(), storeName: widget.storeName,),
                                ),
                              ),
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
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        addToCart(product);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        backgroundColor: const Color(
                                            0xFF612C7D), // Couleur de fond du bouton
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Ajouter au panier",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(Icons.shopping_cart,
                                              color: Colors.white),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

