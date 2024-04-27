import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niefeko/Components/Categories/categorie.dart';
import 'package:niefeko/Components/Deals/deal.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';
import 'package:niefeko/Pages/Connexion/conexion.dart';
import 'package:niefeko/Reutilisable/carteReu.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Section de recherche
              Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF593070),
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(40.0),
                      bottomRight: const Radius.circular(40.0),
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(55.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                    height: 250,
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
                      SizedBox(height: 10),
                  Container(
                    // height: 30,
                    child:   TextField(
  decoration: InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      vertical: 3, // Ajustez cette valeur pour réduire la hauteur de l'input
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
                      SizedBox(height: 15),

                      // Carousel
                      CarouselSlider(
                        items: [
                          //1st Image of Slider
                          carteReu(
                            image: Image.asset(
                              "sac.png",
                              fit: BoxFit.cover,
                            ),
                            title: "Nouveau",
                            paragraph: "50%",
                            texte: "Trouvez ce que vous aimez, à prix malins !",
                          ),
                          //2nd Image of Slider
                          carteReu(
                            image: Image.asset(
                              "lunette.png",
                              fit: BoxFit.cover,
                            ),
                            title: "Nouveau",
                            paragraph: "50%",
                            texte: "Trouvez ce que vous aimez, à prix malins !",
                          ),
                          //3rd Image of Slider
                          carteReu(
                            image: Image.asset(
                              "shoes.png",
                              fit: BoxFit.cover,
                            ),
                            title: "Nouveau",
                            paragraph: "50%",
                            texte: "Trouvez ce que vous aimez, à prix malins !",
                          ),
                          //4th Image of Slider
                          carteReu(
                            image: Image.asset(
                              "t-shirt.png",
                              fit: BoxFit.cover,
                            ),
                            title: "Nouveau",
                            paragraph: "50%",
                            texte: "Trouvez ce que vous aimez, à prix malins !",
                          ),
                          //5th Image of Slider
                          carteReu(
                            image: Image.asset(
                              "sac.png",
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
                          aspectRatio: 15 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),

                    ],
                  )),

              // Votre Container contenant la catégorie
              Column(
                children: [
                  SizedBox(height: 120),
                  categorie(),
                  deal(),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(40.0),
          //     topRight: Radius.circular(40.0),
          //   ),

          color: Color(0xFF593070),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => search(),
                    ),
                  );
                },
                icon: Icon(Icons.home, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(),
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(),
                    ),
                  );
                },
                icon: Icon(Icons.favorite, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(),
                    ),
                  );
                },
                icon: Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),
        ));
  }
}