import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

// ignore: camel_case_types
class deal extends StatefulWidget {
  const deal({super.key});

  @override
  State<deal> createState() => _dealState();
}

// ignore: camel_case_types
class _dealState extends State<deal> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Special Vente",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Action à effectuer lorsque "Voir Plus" est cliqué
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Voir Plus",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black, // Couleur de la flèche
                      size: 20, // Taille de la flèche
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // SizedBox(height: 10),
          CarouselSlider(
            items: [
              //1st Image of Slider
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset("casque.png", fit: BoxFit.contain),
              ),
              //2nd Image of Slider
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset(
                  "tshirtRouge.png",
                  width: 120,
                  height: 60,
                ),
              ),
              //3rd Image of Slider
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset(
                  "montre.png",
                  width: 120,
                  height: 60,
                ),
              ),
              //4th Image of Slider
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset(
                  "sacoche.png",
                  width: 120,
                  height: 60,
                ),
              ),
              //5th Image of Slider
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset(
                  "pot.png",
                  width: 120,
                  height: 60,
                ),
              ),
            ],
            //Slider Container properties
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
              viewportFraction: 0.4, // Une image à la fois
            ),
          ),
          // SizedBox(height: 500)
        ],
      ),
    );
  }
}
