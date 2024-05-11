import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:niefeko/Reutilisable/carteReu.dart';

class carte extends StatefulWidget {
  const carte({super.key});

  @override
  State<carte> createState() => _carteState();
}

class _carteState extends State<carte> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [ // Section de recherche
              Positioned.fill(
                child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF593070),
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
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
                        SizedBox(height: 10),
                        Container(
                          // height: 30,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    3, // Ajustez cette valeur pour réduire la hauteur de l'input
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
                      ],
                    )),
              ),
              // Carousel
              Positioned.fill(
                top: 100,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF593070),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                        ),
                      ),
                    ),
                    CarouselSlider(
                      items: [
                        // Vos éléments Carousel
                        //1st Image of Slider
                        carteReu(
                          image: Image.asset(
                            "sac1.png",
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
                            "sac1.png",
                            fit: BoxFit.cover,
                          ),
                          title: "Nouveau",
                          paragraph: "50%",
                          texte: "Trouvez ce que vous aimez, à prix malins !",
                        ),
                      ],
                      options: CarouselOptions(
                        // Options du Carousel
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    ),
                  ],
                ))
              // Votre Container contenant la catégorie],);
  
],);
  }
}