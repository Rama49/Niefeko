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

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  final ScrollController _scrollController = ScrollController();

  get userId => "36";

  void removeFromCart(int index) {
    setState(() {
      //cartItems.removeAt(index);
    });
  }

  bool _isLoggedOut = false;

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
        context,
        MaterialPageRoute(builder: (context) => const connexion()),
      );
    } catch (e) {
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
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
                    : 250,
              ),
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    "Bienvenue à Niefeko",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CarouselSlider(
                    items: [
                      carteReu(
                        image: Image.asset(
                          "assets/Gommage-Makeda-removebg-preview.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      carteReu(
                        image: Image.asset(
                          "assets/Gommage-Makeda-100g-removebg-preview.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      carteReu(
                        image: Image.asset(
                          "assets/Detox-Intime-removebg-preview.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      carteReu(
                        image: Image.asset(
                          "assets/Gomme-Matify-Me-removebg-preview.png",
                          fit: BoxFit.cover,
                        ),
                        title: "Nouveau",
                        paragraph: "50%",
                        texte: "Trouvez ce que vous aimez, à prix malins !",
                      ),
                      carteReu(
                        image: Image.asset(
                          "assets/Lait-Valouté-Cacao-removebg-preview.png",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 120),
                  Categorie(),
                  deal(),
                  product(),
                ],
              ),
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
                      MaterialPageRoute(builder: (context) => pagefavoris()),
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
