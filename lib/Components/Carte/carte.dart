import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:niefeko/Components/Carte/Categories/categorie.dart';
import 'package:niefeko/Components/Carte/Recherche/recherche.dart';
import 'package:niefeko/Reutilisable/carteReu.dart';

class carte extends StatefulWidget {
  const carte({super.key});

  @override
  State<carte> createState() => _carteState();
}

class _carteState extends State<carte> {
  @override
  Widget build(BuildContext context) {
    return
     Container(
      //  width: 400,
      child: CarouselSlider(
        items: [
          //1st Image of Slider
          Column(children: [
            Flexible(
              child: carteReu(
                image: Image.asset(
                  "sac.png",
                  // height: 165,
                ),
                title: "Nouveau",
                paragraph: "50%",
                texte: "avoir le produit dans vos panier.",
              ),
            ),
          ]),

          //2nd Image of Slider
          Column(children: [
            Flexible(
              child: carteReu(
                image: Image.asset(
                  "lunette.png",
                  // height: 150,
                  // width: 140,
                ),
                title: "Nouveau",
                paragraph: "50%",
                texte: "avoir le produit dans vos panier.",
              ),
            ),
          ]),

          //3rd Image of Slider
          Column(children: [
            Flexible(
              child: carteReu(
                image: Image.asset(
                  "shoes.png",
                  // height: 150,
                  // width: 140,
                ),
                title: "Nouveau",
                paragraph: "50%",
                texte: "avoir le produit dans vos panier.",
              ),
            ),
          ]),

          //4th Image of Slider
          Column(children: [
            Flexible(
              child: carteReu(
                image: Image.asset(
                  "t-shirt.png",
                  // height: 165,
                ),
                title: "Nouveau",
                paragraph: "50%",
                texte: "avoir le produit dans vos panier.",
              ),
            ),
          ]),
          // SizedBox(height: 200),
          //5th Image of Slider
          Column(children: [
            Flexible(
              child: carteReu(
                image: Image.asset(
                  "sac.png",
                  height: 165,
                ),
                title: "Nouveau",
                paragraph: "50%",
                texte: "avoir le produit dans vos panier.",
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
    );
  }
}
