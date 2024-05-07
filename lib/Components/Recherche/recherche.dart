// Components/Recherche/recherche.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:niefeko/Components/Categories/Categorie.dart';
import 'package:niefeko/Components/Deals/Deal.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';
import 'package:niefeko/Pages/Connexion/connexion.dart';
import 'package:niefeko/Pages/Favoris/PageFavoris.dart';
import 'package:niefeko/Pages/PanierHistorique/PanierPage.dart';
import 'package:niefeko/Pages/SettingsPage/SettingsPage.dart';
import 'package:niefeko/Reutilisable/carteReu.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
   List<SearchProduct> cartItems = [];

  // Fonction removeFromCart pour illustrer
  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // ignore: unused_element
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Fluttertoast.showToast(
        msg: "Vous vous êtes déconnecté avec succès",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Connexion()),
      );
    } catch (e) {
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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "Bienvenue à Niefeko",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 30,
                    child: TextField(
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
                  const SizedBox(height: 15),
                  CarouselSlider(
                    items: [
                      CarteReu(
                        image: Image.asset(
                          "sac1.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      CarteReu(
                        image: Image.asset(
                          "lunette.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      CarteReu(
                        image: Image.asset(
                          "shoes.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      CarteReu(
                        image: Image.asset(
                          "t-shirt.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      CarteReu(
                        image: Image.asset(
                          "sac1.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                    ],
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
                Deal(),
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
                  MaterialPageRoute(builder: (context) => const Search()),
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
                  MaterialPageRoute(builder: (context) => PageFavoris()),
                );
              },
              icon: const Icon(Icons.favorite, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
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

class SearchProduct {
  final String name;
  final int price;
  final String imagePath;

  const SearchProduct({
    required this.name,
    required this.price,
    required this.imagePath,
  });
}