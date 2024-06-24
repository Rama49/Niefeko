import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
//import 'package:niefeko/Pages/Category/DetailFournisseur.dart';

class FournisseurProduct extends StatefulWidget {
  final int supplierId;

  FournisseurProduct({required this.supplierId});

  @override
  _FournisseurProductState createState() => _FournisseurProductState();
}

class _FournisseurProductState extends State<FournisseurProduct> {
  late Map<int, Product> products;
  List<Product> filteredProducts = [];
  List<Product> cartItems =
      []; // Liste pour stocker les produits ajoutés au panier
  bool isLoading = true;
  int cartItemCount = 0;
  
  get userId => "";

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
        builder: (context) => CartPanier(cartItems: cartItems)
    ));
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
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(48.0),
        //   child: Container(
        //     margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(7),
        //       color: Colors.white,
        //     ),
        //     child: TextField(
        //       decoration: InputDecoration(
        //         hintText: 'Rechercher...',
        //         prefixIcon: Icon(Icons.search, color: Colors.grey),
        //         border: InputBorder.none,
        //       ),
        //       style: TextStyle(color: Colors.black),
        //       onChanged: searchProduct,
        //     ),
        //   ),
        // ),
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
                          // onTap: () => Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => DetailFournisseur(product: product, productId: product.id),
                          //       ),
                          //     ),
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


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class FournisseurProduct extends StatefulWidget {
//   final int supplierId;

//   FournisseurProduct({required this.supplierId});

//   @override
//   _FournisseurProductState createState() => _FournisseurProductState();
// }

// class _FournisseurProductState extends State<FournisseurProduct> {
//   List<dynamic> products = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     final url = 'https://niefeko.com/wp-json/dokan/v1/stores/${widget.supplierId}/products'; // Remplacez par l'URL de votre API pour récupérer les produits par fournisseur
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         setState(() {
//           products = json.decode(response.body);
//         });
//       } else {
//         throw 'Erreur de chargement des produits';
//       }
//     } catch (e) {
//       print('Erreur lors de la récupération des produits: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Liste des Produits'),
//       ),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (BuildContext context, int index) {
//           final product = products[index];
//           final productName = product['name'] ?? 'Nom inconnu';
//           final productDescription = product['description'] ?? '';
//           final productPrice = product['price'] ?? 'Prix inconnu';
//           return Card(
//             child: ListTile(
//               title: Text(productName),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(productDescription),
//                   SizedBox(height: 8),
//                   Text('Prix: $productPrice'),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

