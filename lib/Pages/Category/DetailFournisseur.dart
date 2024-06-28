import 'package:flutter/material.dart';
import 'package:niefeko/Components/Category/product.dart';
//import 'package:niefeko/Components/produitcart/FournisseurProduct.dart';
//mport 'package:niefeko/Pages/Recherche/recherche.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';




class DetailFournisseur extends StatefulWidget {
  final Product product;
  final String supplierId;
  final String storeName; 
  const DetailFournisseur({super.key, required this.product, required this.supplierId, required this.storeName});
   _DetailState createState() => _DetailState();

  }
  //int quantity = 1;
  int index = 0;
class _DetailState extends State<DetailFournisseur> {
  late Map<int, Product> products;
  List<dynamic> suppliers = [];
  List<bool> isFavoritedList = List.generate(20, (index) => false);
  List<double> prices = [];
  List<String> filteredImagePaths = [];
  List<String> imagePaths = [];
  int cartItemCount = 0;
  List<Product> cartItems = [];
  late Product product;
  List<int> favoriteItems = [];
  bool isLoadingMore = false;
  int currentPage = 1;
  final int productsPerPage = 10;
  bool isLoading = true;
  List<Product> filteredProducts = [];



  @override
  void initState() {
    super.initState();
    fetchProductDetails(widget.supplierId);
    filteredImagePaths.addAll(imagePaths);
    product = Product(id: 0, imagePath: '', name: '', description: '', price: 0);
    products = {};
    fetchData();
    loadFavorites(); 
    loadCartItems();
  }

  Future<void> fetchProductDetails(String supplierId) async {
    final apiUrl =
        Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/products');
    final payload = {"id": supplierId};

    try {
      final response = await http.post(
        apiUrl,
        body: json.encode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          product = Product.fromJson(data);
        });
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (error) {
      print('Error fetching product details: $error');
    }
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

    ///////
    //final response = await http.get(Uri.parse(
        'https://niefeko.com/wp-json/dokan/v1/stores/${widget.supplierId}/products';
        //));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        for (var json in responseData) {
          final product = Product(
            id: json['id'] ?? 0,
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
  ///////////////////////////

  void removeToCart(Product product){
    int existingIndex = 0;
    setState(() {
      cartItems[existingIndex].quantity--;
      cartItemCount--;
    });
  }

  // void addToCart(Product product) async {
  //   String imageUrl = product.imagePath;
  //   String productName = product.name;
  //   double price = product.price;
  //   //String description = product.description;

  //   // Vérifier si le produit existe déjà dans le panier
  //   int existingIndex =
  //       cartItems.indexWhere((product) => product.name == productName);
  //   if (existingIndex != -1) {
  //     // Le produit existe déjà dans le panier, augmentez simplement la quantité
  //     setState(() {
  //       cartItems[existingIndex].quantity++; // Augmenter la quantité du produit
  //       cartItemCount++; // Augmenter le nombre total d'articles dans le panier
  //     });
  //   } else {
  //     // Le produit n'existe pas encore dans le panier, l'ajouter
  //     setState(() {
  //       cartItems.add(Product(
  //         id: 0,
  //         imagePath: imageUrl,
  //         name: productName,
  //         description: product.description,
  //         price: price,
  //         quantity: 1, // Initialiser la quantité à 1
  //       ));
  //       cartItemCount++; // Augmenter le nombre total d'articles dans le panier
  //     });
  //   }
  // }
  ////////////////////////////
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
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('Produit ajouté au panier'),
    //       content: Text('${product.name} a été ajouté à votre panier.'),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('OK'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
      //},
    //);
  }
  ///////////
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
  /////////

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
      cartItemCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildCard(
        index,
        Product(
            id: 0,
            imagePath: widget.product.imagePath,
            name: widget.product.name,
            description: widget.product.description,
            price: widget.product.price));
  }

  Widget buildCard(index, Product product){
    final isFavorite = favoriteItems.contains(product.id);
    return Scaffold(
    backgroundColor: Color(0xFF593070),
    body: Column(
      children: [
        SizedBox(height: 36),
       Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => FournisseurProduct(supplierId: suppliers.length, storeName: suppliers.toString()),
                  //   ),
                  // );
                Navigator.pop(context);
                },
               
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              IconButton(
                                onPressed: () {
                                  toggleFavorite(product);
                                },
                             icon:    Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.white,
                                ),
                                style: IconButton.styleFrom(
                    fixedSize: const Size(55, 55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * .20,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.network(product.imagePath,
            fit: BoxFit.contain,
            ),
            
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 15, left: 40, right: 40)),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF593070),
                          ),
                        ),
                        Text(
                          '${product.price}F',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                               onPressed: (){
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => search(),
                  //   ),
                  // );
                  Navigator.pop(context);
                },
                               child: Row(
                                children:  [
                                Text(
                                widget.storeName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF593070),
                                  ),
                                ),
                                Icon(Icons.storage_rounded),
                              ]),
                            )
                          ],
                        ),

                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF593070),
                          ),
                        ),
                        const SizedBox(height: 10),
                          Html(
                            data: product.description,
                        ),
                        const SizedBox(height: 10),
                        // SizedBox(
                        //   height: 70,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: 5,
                        //     itemBuilder: (context, Color) => 
                        //     Container(
                        //       margin: const EdgeInsets.only(right: 6),
                        //       width: 200,
                        //       //height: 10,
                        //       decoration: BoxDecoration(
                        //         color: Colors.grey.shade100,
                        //         borderRadius: BorderRadius.circular(40),
                        //       ),

                        //       child: ElevatedButton(onPressed: (){
                        //                   setState(() {
                        //                   addToCart(product);
                        //                               },);},
                        //       child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             //ColorFiltered(colorFilter: ColorFilter.mode(Colors.black, BlendMode.colorBurn)),
                        //              Image(
                        //                 height: 70,
                        //                 image: AssetImage(product.imagePath), //color: colors[Color]
                        //                 ),
                        //             Text(
                        //               product.name, 
                        //               //textAlign: TextAlign.center,
                        //               style: TextStyle(fontSize: 15),
                        //             )
                        //           ]
                        //           ),)
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 140,
        // width: 200,
        // color: Color(0xFF593070),
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        width: double.infinity,
        //height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Color(0xFF593070),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 150,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        if (cartItemCount > 1) {
                          setState(() {
                            cartItemCount --;
                            removeToCart(product);
                          });
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        color: Color(0xFF593070),
                        size: 25,
                      )),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${cartItemCount}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          cartItemCount ++ ;
                          addToCart(product);
                        });
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: Color(0xFF593070),
                        size: 25,
                      ))
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () => {
                  openCart()
                }, //navigateToCartPage(),
                child: Container(
                  width: 150,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    '+ Ajouter au panier',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF593070),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
