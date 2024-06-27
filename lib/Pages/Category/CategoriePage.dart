import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:niefeko/Components/Category/product.dart'; // Assurez-vous d'importer correctement Product depuis son emplacement réel
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
  bool isLoadingMore = false;
  int cartItemCount = 0;
  int currentPage = 1;
  final int productsPerPage = 10;

  @override
  void initState() {
    super.initState();
    products = {};
    loadFavorites(); // Charger les favoris au démarrage
    fetchData();
    loadCartItems();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favoriteItems = prefs.getStringList('favoriteItems')?.map((id) => int.parse(id))?.toList() ?? [];
  }

  Future<void> toggleFavorite(Product product) async {
    final url = Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/favorits');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      final response = await http.post(
        url,
        body: json.encode({"id": product.id}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          if (favoriteItems.contains(product.id)) {
            favoriteItems.remove(product.id);
            // Afficher une notification de suppression des favoris
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} retiré des favoris'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Annuler',
                  onPressed: () {
                    // Annuler l'action si nécessaire
                    toggleFavorite(product);
                  },
                ),
              ),
            );
          } else {
            favoriteItems.add(product.id);
            // Afficher une notification d'ajout aux favoris
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} ajouté aux favoris'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Annuler',
                  onPressed: () {
                    // Annuler l'action si nécessaire
                    toggleFavorite(product);
                  },
                ),
              ),
            );
          }
        });

        // Enregistrer les favoris mis à jour dans SharedPreferences
        await prefs.setStringList('favoriteItems', favoriteItems.map((id) => id.toString()).toList());
      } else {
        print('Échec de la mise à jour des favoris: ${response.statusCode}');
        throw Exception('Échec de la mise à jour des favoris');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour des favoris: $e');
      // Afficher une boîte de dialogue en cas d'erreur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Une erreur est survenue lors de la mise à jour des favoris.'),
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

  Future<void> fetchData({bool loadMore = false}) async {
    if (loadMore) {
      setState(() {
        isLoadingMore = true;
      });
    } else {
      setState(() {
        isLoading = true;
      });
    }

    final response = await http.get(
      Uri.parse('https://niefeko.com/wp-json/dokan/v1/stores/16/products?page=$currentPage&per_page=$productsPerPage'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print('Response data: $responseData'); // Vérifier la structure des données reçues

      setState(() {
        for (var json in responseData) {
          final product = Product.fromJson(json);
          products[product.id] = product;
        }
        filteredProducts = products.values.toList();
        isLoading = false;
        isLoadingMore = false;
        currentPage++;
      });
    } else {
      print('Échec du chargement des produits: ${response.statusCode}');
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

  Future<void> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson = prefs.getStringList('cartItems') ?? [];
    setState(() {
      cartItems = cartItemsJson
          .map((item) => Product.fromJson(json.decode(item)))
          .toList();
      cartItemCount = cartItems.fold(0, (sum, item) => sum + item.quantity);
    });
  }

  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);
      cartItemCount = cartItems.length;
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

  void openCart() async {
  // Naviguer vers la page du panier
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CartPanier(
        cartItems: cartItems,
        user_firstname: "",
        user_lastname: "",
        user_email: "",
      ),
    ),
  );

  // Après avoir validé le panier, réinitialiser le contenu du panier
  setState(() {
    cartItems.clear(); // Vider la liste des produits dans le panier
    cartItemCount = 0; // Réinitialiser le compteur du nombre d'articles dans le panier
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
                hintText: 'Rechercher un produit...',
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
              : NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!isLoadingMore &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      fetchData(loadMore: true);
                      return true;
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: filteredProducts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == filteredProducts.length) {
                        return isLoadingMore
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox();
                      }
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
                                      child: product.imagePath != null
                                          ? Image.network(
                                              product.imagePath!,
                                              height: 130,
                                              width: 130,
                                              errorBuilder: (context
                                    , error, stackTrace) =>
                                              Image.asset(
                                                '',
                                                height: 130,
                                                width: 130,
                                              ),
                                            )
                                          : Image.asset(
                                              'assets/tshirt1.jpg',
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
                                    Html(data: product.description),
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
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    const Color(0xFF612C7D)),
                                            padding:
                                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                              EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 10),
                                            ),
                                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
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
                ),
    );
  }
}