import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niefeko/Components/Categories/categorie.dart';
<<<<<<< HEAD
import 'package:niefeko/Components/Category/product.dart';
=======
>>>>>>> 683be5876ab5a2878c36e8832f61f6a97515fa44
import 'package:niefeko/Components/Deals/deal.dart';
// ignore: unused_import
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';
import 'package:niefeko/Pages/Connexion/connexion.dart';
import 'package:niefeko/Pages/Favoris/pagefavoris.dart';
import 'package:niefeko/Pages/PanierHistorique/PanierPage.dart';
import 'package:niefeko/Pages/SettingsPage/SettingsPage.dart';
import 'package:niefeko/Reutilisable/carteReu.dart';
import 'package:carousel_slider/carousel_slider.dart';
<<<<<<< HEAD
=======
import 'package:niefeko/Components/Category/product.dart';
>>>>>>> 683be5876ab5a2878c36e8832f61f6a97515fa44

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
<<<<<<< HEAD
    Product(imagePath: "imagePath", name: "name", description: "description", price: 0),
=======
    Product(name: '', price: 0, description: '', imagePath: ''),
>>>>>>> 683be5876ab5a2878c36e8832f61f6a97515fa44
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
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // ignore: use_build_context_synchronously
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
        backgroundColor: Colors.red,
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
        child: Flexible(
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
                      // ignore: sized_box_for_whitespace
                     Container(
                    height: 40,
                    padding: EdgeInsets.only(right: 25, left: 25),
                    child: TextField(
                      // onChanged: searchProduct,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 3,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Rechercher un produit",
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.black,
                      ),
                    ),
                  ),
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
                  )),

              // Votre Container contenant la catégorie
              const Column(
                children: [
                  SizedBox(height: 120),
                  Categorie(),
                  deal(),
                ],
              ),
            ],
          ),
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
                  // ignore: prefer_const_constructors
                  MaterialPageRoute(builder: (context) => search()),
                );
              },
              icon: const Icon(Icons.home, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                // Naviguer vers la page d'historique des commandes
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
                // Ajoutez ici votre logique de navigation pour l'écran des favoris
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