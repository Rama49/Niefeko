import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Map<int, Product> products;
  List<Product> filteredProducts = [];
  List<Product> cartItems = [];
  List<int> favoriteItems = [];
  bool isLoading = true;
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    products = {};
    fetchData();
    loadCartItems();
  }

  Future<void> fetchData() async {
  final response = await http.get(Uri.parse('https://niefeko.com/wp-json/dokan/v1/stores/16/products'));

  if (response.statusCode == 200) {
    final List<dynamic> responseData = json.decode(response.body);
    setState(() {
      products.clear(); // Clear existing products map
      filteredProducts.clear(); // Clear filtered products list
      for (var json in responseData) {
        try {
          final product = Product.fromJson(json);
          products[product.id] = product;
        } catch (e) {
          print('Error parsing product: $e');
        }
      }
      filteredProducts.addAll(products.values);
      isLoading = false;
    });
  } else {
    throw Exception('Échec du chargement des produits');
  }
}


  Future<void> saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson = cartItems.map((product) => json.encode(product.toMap())).toList();
    await prefs.setStringList('cartItems', cartItemsJson);
  }

  Future<void> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson = prefs.getStringList('cartItems') ?? [];
    setState(() {
      cartItems = cartItemsJson.map((item) => Product.fromJson(json.decode(item))).toList();
      cartItemCount = cartItems.fold(0, (sum, item) => sum + item.quantity);
    });
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
      final existingProductIndex = cartItems.indexWhere((item) => item.id == product.id);
      if (existingProductIndex >= 0) {
        cartItems[existingProductIndex].quantity += 1;
      } else {
        cartItems.add(product);
      }
      cartItemCount = cartItems.fold(0, (sum, item) => sum + item.quantity);
      saveCartItems();
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
      if (favoriteItems.contains(product.id)) {
        favoriteItems.remove(product.id);
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
        favoriteItems.add(product.id);
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
                onPressed: openCart,
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
                    cartItemCount.toString(),
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
                    final isFavorite = favoriteItems.contains(product.id);
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
                                          backgroundColor: const Color(0xFF612C7D),
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
