// ignore_for_file: camel_case_types

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Categorie extends StatefulWidget {
  const Categorie({Key? key}) : super(key: key);

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
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
              buildCarouselItem("gourde.png", "Gourde"),
              //2nd Image of Slider
              buildCarouselItem("pantalon.png", "Pantalon"),
              //3rd Image of Slider
              buildCarouselItem("lunnete1.png", "Lunettes"),
              //4th Image of Slider
              buildCarouselItem("torche.png", "Torche"),
              //5th Image of Slider
              buildCarouselItem("maronshoes.png", "Chaussures"),
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
    return Container(
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
