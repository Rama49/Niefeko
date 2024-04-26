import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niefeko/Components/Carte/Navbar/menu.dart';
import 'package:niefeko/Components/Category/Categorie.dart';
import 'package:niefeko/Components/Category/CategorieHeader.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';
import 'package:niefeko/Reutilisable/carteReu.dart';
import 'package:niefeko/Pages/Connexion/conexion.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
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
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => connexion()),
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
      body: Stack(
        children: [
          // First section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF593070),
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(40.0),
                  bottomRight: const Radius.circular(40.0),
                ),
              ),
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 60,
                  child: Container(
                    child: Column(
                      children: [
                        const Text(
                          "Bienvenue à Niefeko",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20),
                        BoutonR(
                          titre: "Déconnexion",
                          onPressed: () async {
                            await _signOut();
                          },
                        ),
                        if (_isLoggedOut)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Vous vous êtes déconnecté de l'application Niefeko",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Second section
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 150,
            child: Column(
              children: [
                Expanded(
                  child: CarouselSlider(
                    items: [
                      //1st Image of Slider
                      Column(children: [
                        Flexible(
                          child: carteReu(
                            image: Image.asset(
                              "sac.png",
                            ),
                            title: "Nouveau",
                            paragraph: "50%",
                            texte: "Avoir le produit dans vos paniers.",
                          ),
                        ),
                      ]),
                      //2nd Image of Slider
                      Column(children: [
                        Flexible(
                          child: carteReu(
                            image: Image.asset(
                              "lunette.png",
                            ),
                            title: "Nouveau",
                            paragraph: "50%",
                            texte: "Avoir le produit dans vos paniers.",
                          ),
                        ),
                      ]),
                      //3rd Image of Slider
                      Column(children: [
                        Flexible(
                          child: carteReu(
                            image: Image.asset(
                              "shoes.png",
                            ),
                            title: "Nouveau",
                            paragraph: "50%",
                            texte: "Avoir le produit dans vos paniers.",
                          ),
                        ),
                      ]),
                      //4th Image of Slider
                      Column(children: [
                        Flexible(
                          child: carteReu(
                            image: Image.asset(
                              "t-shirt.png",
                            ),
                            title: "Nouveau",
                            paragraph: "50%",
                            texte: "Avoir le produit dans vos paniers.",
                          ),
                        ),
                      ]),
                      //5th Image of Slider
                      Column(children: [
                        Flexible(
                          child: carteReu(
                            image: Image.asset(
                              "sac.png",
                            ),
                            title: "Nouveau",
                            paragraph: "50%",
                            texte: "Avoir le produit dans vos paniers.",
                          ),
                        ),
                      ]),
                    ],
                    //Slider Container properties
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center( // Centrer le bouton
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategorieHeader(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF612C7D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "Créer un compte",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
