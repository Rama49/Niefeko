import 'package:flutter/material.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
import 'package:niefeko/Pages/Recherche/recherche.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Couleur {
  final Color bleu, rouge, vert, jaune, noir;
  Couleur({
    required this.bleu,
    required this.rouge,
    required this.vert,
    required this.jaune,
    required this.noir,
  });
}

class Detail extends StatefulWidget {
  final Product product;
  const Detail({super.key, required this.product});
  _DetailState createState() => _DetailState();
}

//int quantity = 1;
int index = 0;

class _DetailState extends State<Detail> {
  List<bool> isFavoritedList = List.generate(20, (index) => false);
  List<double> prices = [];
  List<String> filteredImagePaths = [];
  List<String> imagePaths = [];
  int cartItemCount = 0;
  List<Product> cartItems = [];
  List<String> nomFournisseur = [];

  @override
  void initState() {
    super.initState();
    filteredImagePaths.addAll(imagePaths);
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    final response = await http.post(
      Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': widget.product.id,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        // Assuming the API response contains imagePath, name, description, and price
        widget.product.imagePath = data['imagePath'];
        widget.product.name = data['name'];
        widget.product.description = data['description'];
        widget.product.price = data['price'];
      });
    } else {
      throw Exception('Failed to load product details');
    }
  }

  void removeToCart(Product product) {
    int existingIndex = 0;
    setState(() {
      cartItems[existingIndex].quantity--;
      cartItemCount--;
    });
  }

  void addToCart(Product product) {
    String imageUrl = product.imagePath;
    String productName = product.name;
    double price = product.price;

    int existingIndex =
        cartItems.indexWhere((product) => product.name == productName);
    if (existingIndex != -1) {
      setState(() {
        cartItems[existingIndex].quantity++;
        cartItemCount++;
      });
    } else {
      setState(() {
        cartItems.add(Product(
          id: product.id,
          imagePath: imageUrl,
          name: productName,
          description: product.description,
          price: price,
          quantity: 1,
        ));
        cartItemCount++;
      });
    }
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
      cartItemCount--;
    });
  }

  Future<void> navigateToCartPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPanier(
          cartItems: cartItems,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildCard(index, Product(
      id: widget.product.id,
      imagePath: widget.product.imagePath,
      name: widget.product.name,
      description: widget.product.description,
      price: widget.product.price,
    ));
  }

  Widget buildCard(index, Product product) {
    List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.black];
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(
                  isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
                  color: isFavoritedList[index] ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isFavoritedList[index] = !isFavoritedList[index];
                  });

                  if (isFavoritedList[index]) {
                    Product favoriteProduct = Product(
                      id: product.id,
                      imagePath: product.imagePath,
                      name: product.name,
                      description: product.description,
                      price: product.price,
                    );

                    addFavoriteToLocal(favoriteProduct);
                  }
                },
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * .20,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.asset(product.imagePath),
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => search(),
                                  ),
                                );
                              },
                              child: Row(
                                children: const [
                                  Text(
                                    'fournisseur',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF593070),
                                    ),
                                  ),
                                  Icon(Icons.storage_rounded),
                                ],
                              ),
                            ),
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
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, Color) => Container(
                              margin: const EdgeInsets.only(right: 6),
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    addToCart(product);
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                      height: 70,
                                      image: AssetImage(product.imagePath),
                                      color: colors[Color],
                                    ),
                                    Text(
                                      product.name,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF593070),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 150,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple.shade200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.shopping_cart),
                  Text(
                    cartItemCount.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple.shade200,
              ),
              child: ElevatedButton(
                onPressed: () {
                  navigateToCartPage();
                },
                child: const Text(
                  'Voir le panier',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addFavoriteToLocal(Product product) {
    // Logic to add the product to local favorites (e.g., local storage, shared preferences)
    // This function can be implemented as per your requirements.
  }
}
