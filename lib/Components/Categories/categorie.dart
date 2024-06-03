// Components/Categories/Categorie.dart
// ignore_for_file: camel_case_types// ignore_for_file: camel_case_types

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:niefeko/Pages/memeCategorie/MemeCategorie.dart';
import 'package:niefeko/Pages/memeCategorie/memeCategorie0.dart';
import 'package:niefeko/Pages/memeCategorie/memeCategorie10.dart';
import 'package:niefeko/Pages/memeCategorie/memeCategorie11.dart';

class Categorie extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Categorie({Key? key});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CarouselSlider(
            items: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MemeCategorie()),
                  );
                },
                child: buildCarouselItem("assets/gourde.png", "Gourde"),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MemeCategorie0()),
                  );
                },
                child: buildCarouselItem("assets/pantalon.png", "Pantalon"),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MemeCategorie11()),
                  );
                },
                child: buildCarouselItem("assets/lunnete1.png", "Lunettes"),
              ),
              //4th Image of Slider
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MemeCategorie10()),
                  );
                },
                child: buildCarouselItem("assets/torche.png", "Torche"),
              ),
              // buildCarouselItem("assets/maronshoes.png", "Maronshoes"),
            ],
            //Slider Container properties
            options: CarouselOptions(
              enlargeCenterPage: false,
              autoPlay: true,
              aspectRatio: 23 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
              viewportFraction: 0.25, // Une image à la fois
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCarouselItem(String imagePath, String text) {
    // ignore: avoid_unnecessary_containers
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 0),
      // color: Colors.amber,
      child: Column(
        children: [
          Container(
            height: 80, // Hauteur du background mauve
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: const Color.fromARGB(255, 215, 194, 233),
            ),
            child: Image.asset(
              imagePath,
              // width: 120,
              height: 100,
            ),
          ),
          const SizedBox(height: 8), // Espacement entre l'image et le texte
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
