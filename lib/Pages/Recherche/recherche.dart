import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niefeko/Components/Categories/categorie.dart';
import 'package:niefeko/Components/Deals/deal.dart';
import 'package:niefeko/Components/produitcart/produit_Card.dart';
import 'package:niefeko/Pages/Connexion/connexion.dart';
import 'package:niefeko/Pages/Favoris/pagefavoris.dart';
import 'package:niefeko/Pages/PanierHistorique/PanierPage.dart';
import 'package:niefeko/Pages/SettingsPage/SettingsPage.dart';
import 'package:niefeko/Reutilisable/carteReu.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:niefeko/Components/Category/product.dart';

// ignore: camel_case_types
class search extends StatefulWidget {
  // ignore: use_super_parameters
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

// ignore: camel_case_types
class _searchState extends State<search> {
  List<Product> cartItems = [
    Product(name: '', price: 0, description: '', imagePath: ''),
  ];

  // Fonction removeFromCart pour illustrer
  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // ignore: unused_field
  bool _isLoggedOut = false;

  // ignore: unused_element
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      setState(() {
        _isLoggedOut = true;
      });
      Fluttertoast.showToast(
        msg: "Vous vous êtes déconnecté avec succès",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: const Color(0xFF612C7D),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const connexion()),
      );
    } catch (e) {
      // ignore: avoid_print
      print("Erreur lors de la déconnexion: $e");
      Fluttertoast.showToast(
        msg: "Erreur lors de la déconnexion: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: const Color(0xFF612C7D),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
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
                  const SizedBox(height: 20),
                  const Text(
                    "Bienvenue à Niefeko",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  // ignore: sized_box_for_whitespace
                  // Container(
                  //   height: 40,
                  //   padding: const EdgeInsets.only(right: 25, left: 25),
                  //   child: TextField(
                  //     // onChanged: searchProduct,
                  //     decoration: InputDecoration(
                  //       contentPadding: const EdgeInsets.symmetric(
                  //         vertical: 3,
                  //       ),
                  //       filled: true,
                  //       fillColor: Colors.white,
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //       hintText: "Rechercher un produit",
                  //       prefixIcon: const Icon(Icons.search),
                  //       prefixIconColor: Colors.black,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),

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
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      //2nd Image of Slider
                      carteReu(
                        image: Image.asset(
                          "assets/lunette.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      //3rd Image of Slider
                      carteReu(
                        image: Image.asset(
                          "assets/shoes.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      //4th Image of Slider
                      carteReu(
                        image: Image.asset(
                          "assets/t-shirt.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      //5th Image of Slider
                      carteReu(
                        image: Image.asset(
                          "assets/sac1.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
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
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
                ],
              ),
            ),

            // Votre Container contenant la catégorie
            const Column(
              children: [
                SizedBox(height: 120),
                Categorie(),
                deal(),
                product(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF612C7D),
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
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
                const Text(
                  "Accueil",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PanierPage()),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                ),
                const Text(
                  "Panier",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const pagefavoris()),
                    );
                  },
                  icon: const Icon(Icons.favorite, color: Colors.white),
                ),
                const Text(
                  "Favoris",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                  icon: const Icon(Icons.settings, color: Colors.white),
                ),
                const Text(
                  "Paramètres",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
