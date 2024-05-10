import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niefeko/Components/Categories/categorie.dart';
import 'package:niefeko/Components/Deals/deal.dart';
import 'package:niefeko/Components/Input/input.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';
import 'package:niefeko/Pages/Connexion/connexion.dart';
import 'package:niefeko/Pages/Favoris/pagefavoris.dart';
import 'package:niefeko/Pages/PanierHistorique/PanierPage.dart';
import 'package:niefeko/Pages/SettingsPage/settingspage.dart';
import 'package:niefeko/Reutilisable/carteReu.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  List<Product> cartItems = [];
  List<bool> isFavoritedList = List.generate(20, (index) => false);
  List<String> imagePaths = [
    'assets/casque.png',
    'assets/chaussure.png',
    'assets/coquillage.png',
    'assets/gourde.png',
    'assets/jordan.png',
    'assets/lunnete1.png',
    'assets/lunette.png',
    'assets/montre.png',
    'assets/pantalon.png',
    'assets/pot.png',
    'assets/sac1.png',
    'assets/sac.jpg',
    'assets/sacoche.png',
    'assets/shoes.png',
    'assets/t-shirt.png',
    'assets/torche.png',
    'assets/tshirt-polo.jpg',
    'assets/tshirt1.jpg',
    'assets/tshirtRouge.png',
    'assets/torche.png',
  ];
  List<double> prices = List.generate(20, (index) => 1000.0);
  List<String> filteredImagePaths = [];
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    filteredImagePaths.addAll(imagePaths);
  }

  void searchProduct(String query) {
    setState(() {
      filteredImagePaths = imagePaths
          .where((path) => path.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void addToCart(int index) async {
    String imageUrl = imagePaths[index];
    String productName = filteredImagePaths[index].split('/').last.split('.').first;
    double price = prices[index];
    DateTime timestamp = DateTime.now(); // Timestamp de la commande

    String idClient = ""; // Remplir avec l'ID du client
    String prenom = ""; // Remplir avec le prénom du client
    String nom = ""; // Remplir avec le nom du client

    // Calculer le montant total
    double totalAmount = price * 1; // Pour l'exemple, mettons la quantité à 1

    // Vérifier si le produit existe déjà dans le panier
    int existingIndex =
        cartItems.indexWhere((product) => product.name == productName);
    if (existingIndex != -1) {
      // Le produit existe déjà dans le panier, augmentez simplement la quantité
      setState(() {
        cartItems[existingIndex].quantity++; // Augmenter la quantité du produit
        cartItemCount++; // Augmenter le nombre total d'articles dans le panier
      });
    } else {
      // Le produit n'existe pas encore dans le panier, l'ajouter
      setState(() {
        cartItems.add(Product(
          imagePath: imageUrl,
          name: productName,
          price: price,
          quantity: 1, // Initialiser la quantité à 1
        ));
        cartItemCount++; // Augmenter le nombre total d'articles dans le panier
      });
    }
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
      cartItemCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Section de recherche
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF593070),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom != 0
                    ? MediaQuery.of(context).padding.bottom
                    : 250, // Ajoutez le padding en bas
              ),
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  const Text(
                    "Bienvenue à Niefeko",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 20),
                
                
                input(),
                
                
                  const SizedBox(height: 30),
                  // Carousel
                  CarouselSlider(
                    items: [
                      //1st Image of Slider
                      carteReu(
                        image: Image.asset(
                          "assets/sac1.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "30%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      //2nd Image of Slider
                      carteReu(
                        image: Image.asset(
                          "assets/lunette.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "10%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      //3rd Image of Slider
                      carteReu(
                        image: Image.asset(
                          "assets/shoes.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "80%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      //4th Image of Slider
                      carteReu(
                        image: Image.asset(
                          "assets/t-shirt.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "40%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      //5th Image of Slider
                      carteReu(
                        image: Image.asset(
                          "assets/sac1.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "90%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                    ],
                    //Slider Container properties
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 12 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            // Votre Container contenant la catégorie
            Column(
              children: const [
                SizedBox(height: 120),
                Categorie(),
                deal()
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF612C7D),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const search()),
                );
              },
              icon: const Icon(Icons.home, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PanierPage()),
                );
              },
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const pagefavoris()),
                );
              },
              icon: const Icon(Icons.favorite, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => settingspage()),
                );
              },
              icon: const Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
