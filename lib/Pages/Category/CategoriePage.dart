import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Map<int, Product> products;
  List<Product> filteredProducts = [];
  List<Product> cartItems = []; // Liste pour stocker les produits ajoutés au panier
  List<int> favoriteItems = []; // Liste pour stocker les produits favoris
  bool isLoading = true;
  int cartItemCount = 0;

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
      cartItems.add(product); // Ajouter le produit à la liste des produits ajoutés au panier
      cartItemCount = cartItems.length; // Mettre à jour le nombre d'articles dans le panier
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
            user_firstname: "",
            user_lastname: "",
            user_email: ""),
      ),
    );
  }

  void toggleFavorite(Product product) {
    setState(() {
      if (favoriteItems.contains(product.hashCode)) {
        favoriteItems.remove(product.hashCode);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Vous n'aimez plus ce produit"),
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
        favoriteItems.add(product.hashCode);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Vous avez aimé ce produit'),
              content: Text('${product.name} a été ajouté à vos favoris.'),
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
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: openCart, // Ouvrir le panier avec les produits ajoutés
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
                    cartItemCount.toString(), // Afficher le nombre de produits dans le panier
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : filteredProducts.isEmpty
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
                    final isFavorite = favoriteItems.contains(product.hashCode);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Card(
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
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          backgroundColor: const Color(0xFF612C7D), // Couleur de fond du bouton
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
                                            Icon(Icons.shopping_cart, color: Colors.white),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                toggleFavorite(product);
                              },
                              child: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}