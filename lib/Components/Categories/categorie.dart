// Components/Categories/Categorie.dart
// ignore_for_file: camel_case_types// ignore_for_file: camel_case_types

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
              //1st Image of Slider
              buildCarouselItem("assets/gourde.png", "Gourde"),
              //2nd Image of Slider
              buildCarouselItem("assets/pantalon.png", "Pantalon"),
              //3rd Image of Slider
              buildCarouselItem("assets/lunnete1.png", "Lunettes"),
              //4th Image of Slider
              buildCarouselItem("assets/torche.png", "Torche"),
              //5th Image of Slider
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
