import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class categorie extends StatefulWidget {
  const categorie({Key? key});

  @override
  State<categorie> createState() => _categorieState();
}

class _categorieState extends State<categorie> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
          // SizedBox(height: 30),
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
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 500),
              viewportFraction: 0.4, // Une image à la fois
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCarouselItem(String imagePath, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: Color.fromARGB(255, 215, 194, 233),
            ),
            child: Image.asset(
              imagePath,
              width: 120,
              height: 60,
            ),
          ),
          SizedBox(height: 8), // Espacement entre l'image et le texte
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
