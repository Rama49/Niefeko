import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:flutter_html/flutter_html.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
import 'package:niefeko/Pages/Category/DetailFournisseur.dart';
//import 'package:niefeko/Pages/Recherche/recherche.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  List<Product> cartItems =  []; 
  bool isLoading = true;
  int cartItemCount = 0;
  List<int> favoriteItems = [];
  bool isLoadingMore = false;
  int currentPage = 1;
  final int productsPerPage = 10;

  @override
  void initState() {
    super.initState();
    products = {};
    fetchData();
    loadFavorites(); 
    loadCartItems();
  
  }
///////////////////////////
Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favoriteItems = prefs.getStringList('favoriteItems')?.map((id) => int.parse(id)).toList() ?? [];
  }
//////////////
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
/////////////


  Future<void> fetchData({bool loadMore = false}) async {
    ////////
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
      Uri.parse('https://niefeko.com/wp-json/dokan/v1/stores/${widget.supplierId}/products?page=$currentPage&per_page=$productsPerPage'),
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

    // ///////
    // //final response = await http.get(Uri.parse(
    //     'https://niefeko.com/wp-json/dokan/v1/stores/${widget.supplierId}/products';
    //     //));

    // if (response.statusCode == 200) {
    //   final List<dynamic> responseData = json.decode(response.body);
    //   setState(() {
    //     for (var json in responseData) {
    //       final product = Product(
    //         id: json['id'],
    //         imagePath: json['images'][0]['src'] ?? '',
    //         name: json['name'] ?? '',
    //         description: json['description'] ?? '',
    //         price: double.parse(json['price'] ?? '0.0'),
    //       );
    //       products[json['id']] = product;
    //     }
    //     filteredProducts = products.values.toList();
    //     isLoading = false;
    //   });
    // } else {
    //   throw Exception('Échec du chargement des produits');
    // }
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
  ///////////////
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

  /////////////

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

  void openCart() {
    Navigator.push(
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        iconTheme: IconThemeData(color: Colors.white),
        title:  Text('Boutique de ${widget.storeName}', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(
            //   context, MaterialPageRoute(
            //     builder: (context) => search(),
            //     )
            //     );
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
                    'Pas de produits pour l\'instant',
                    style: TextStyle(color: Color(0xFF612C7D), fontSize: 18),
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
                              child: GestureDetector(
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailFournisseur(product: product, supplierId: supplier.toString(), storeName: widget.storeName,),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      // ignore: unnecessary_null_comparison
                                      child: product.imagePath != null
                                          ? Image.network(
                                              product.imagePath,
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
                                              '',
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
                                    // SizedBox(height: 8),
                                    // Html(data: product.description),
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

