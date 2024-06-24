import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:niefeko/Components/Category/product.dart'; // Assurez-vous d'importer correctement Product
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';

class FournisseurProduct extends StatefulWidget {
  final int supplierId;

  FournisseurProduct({required this.supplierId});

  @override
  _FournisseurProductState createState() => _FournisseurProductState();
}

class _FournisseurProductState extends State<FournisseurProduct> {
  late List<Product> products;
  List<Product> filteredProducts = [];
  List<Product> cartItems = [];
  bool isLoading = true;
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    products = [];
    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        'https://niefeko.com/wp-json/dokan/v1/stores/${widget.supplierId}/products';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          products = responseData.map((json) => Product.fromJson(json)).toList();
          filteredProducts = List.from(products);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void searchProduct(String query) {
    final results = products.where((product) =>
        product.name.toLowerCase().contains(query.toLowerCase())).toList();

    setState(() {
      filteredProducts = results;
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
          title: Text('Product Added to Cart'),
          content: Text('${product.name} has been added to your cart.'),
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
          user_email: "user_email"
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
        title: const Text('Products', style: TextStyle(color: Colors.white)),
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
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : filteredProducts.isEmpty
              ? Center(
                  child: Text(
                    'No products available at the moment',
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
                                        backgroundColor: const Color(
                                            0xFF612C7D), // Button background color
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Add to Cart",
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
