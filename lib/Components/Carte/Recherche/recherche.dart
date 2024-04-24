import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:niefeko/Components/Carte/Categories/categorie.dart';
import 'package:niefeko/Components/Carte/Navbar/menu.dart';
import 'package:niefeko/Reutilisable/carteReu.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Premier Positioned pour la section de recherche
          Container(
            height: 400, // Ajustez la hauteur ici
            child: Stack(
              children: [
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
                              TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xfff1f1f1),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Recherche un produit",
                                  prefixIcon: const Icon(Icons.search),
                                  prefixIconColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Deuxième Positioned pour la carousel
                Positioned(
                  left: 0,
                  right: 0,
                  top: 100,
                  bottom: 0,
                  child: Container(
                    child: CarouselSlider(
                      items: [
                        //1st Image of Slider
                        Column(
                          children: [
                            Flexible(
                              child: carteReu(
                                image: Image.asset(
                                  "sac.png",
                                ),
                                title: "Nouveau",
                                paragraph: "50%",
                                texte: "Trouvez ce que vous aimez, à prix malins !",
                              ),
                            ),
                          ],
                        ),
                        //2nd Image of Slider
                        Column(
                          children: [
                            Flexible(
                              child: carteReu(
                                image: Image.asset(
                                  "lunette.png",
                                ),
                                title: "Nouveau",
                                paragraph: "50%",
                                texte: "Trouvez ce que vous aimez, à prix malins !",
                              ),
                            ),
                          ],
                        ),
                        //3rd Image of Slider
                        Column(
                          children: [
                            Flexible(
                              child: carteReu(
                                image: Image.asset(
                                  "shoes.png",
                                ),
                                title: "Nouveau",
                                paragraph: "50%",
                                texte: "Trouvez ce que vous aimez, à prix malins !",
                              ),
                            ),
                          ],
                        ),
                        //4th Image of Slider
                        Column(
                          children: [
                            Flexible(
                              child: carteReu(
                                image: Image.asset(
                                  "t-shirt.png",
                                ),
                                title: "Nouveau",
                                paragraph: "50%",
                                texte: "Trouvez ce que vous aimez, à prix malins !",
                              ),
                            ),
                          ],
                        ),
                        //5th Image of Slider
                        Column(
                          children: [
                            Flexible(
                              child: carteReu(
                                image: Image.asset(
                                  "sac.png",
                                ),
                                title: "Nouveau",
                                paragraph: "50%",
                                texte: "Trouvez ce que vous aimez, à prix malins !",
                              ),
                            ),
                          ],
                        ),
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
                ),
              ],
            ),
          ),
          // Votre Container contenant la catégorie
          Expanded(
            child: Container(
              child: categorie(),
            ),
          ),
        ],
      ),
    );
  }
}
