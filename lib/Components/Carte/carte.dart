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
    return Container(
             width: 400,
      child: CarouselSlider(
        items: [
          //1st Image of Slider
          Column(
            children:[ carteReu(
              image: Image.asset(
                "sac.png",
                height: 165,
              ),
                  title: "Nouveau",
              paragraph: "50%",
              texte:
                  "avoir le produit dans vos panier.",
            ),]
          ),

          //2nd Image of Slider
          Column(
            children:[ carteReu(
              image: Image.asset(
                "lunette.png",
                height: 150,
                width: 140,
              ),
              title: "Nouveau",
              paragraph: "50%",
              texte:
                  "avoir le produit dans vos panier.",
            ),]
          ),

          //3rd Image of Slider
          Column(
            children:[ carteReu(
              image: Image.asset(
                "shoes.png",
                height: 150,
                width: 140,
              ),
                  title: "Nouveau",
              paragraph: "50%",
              texte:
                  "avoir le produit dans vos panier.",
            ),]
          ),

          //4th Image of Slider
           Column(
            children:[ carteReu(
              image: Image.asset(
                "t-shirt.png",
                height: 165,
              ),
                  title: "Nouveau",
              paragraph: "50%",
              texte:
                  "avoir le produit dans vos panier.",
            ),]
          ),
          SizedBox(height: 200),
          //5th Image of Slider
          Column(
            children:[ carteReu(
              image: Image.asset(
                "sac.png",
                height: 165,
              ),
                  title: "Nouveau",
              paragraph: "50%",
              texte:
                  "avoir le produit dans vos panier.",
            ),]
          ),
        ],

        //Slider Container properties
        options: CarouselOptions(
          height: 315,
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
    //  Column(
    //   children: [

    //     Row(
    //       children: [
    //         Container(
    //           margin: const EdgeInsets.all(5),
    //           color: const Color.fromARGB(255, 101, 54, 244),
    //           width: 150,
    //           height: 150,
    //           child: carteReu(
    //             image: Image.asset(
    //               "sac.jpg",
    //             ),
    //             title: "lorem ipsum",
    //             paragraph: "Developpeur React Native",
    //             texte:
    //                 "Lorem ipsum dolor sit amet consectetur.\nArcu consectetur fringilla gravida mauris.",
    //           ),
    //         ),
    //         Container(
    //           margin: const EdgeInsets.all(5),
    //           color: const Color.fromARGB(255, 101, 54, 244),
    //           width: 150,
    //           height: 150,
    //           child: carteReu(
    //             image: Image.asset(
    //               "shoes.jpg",
    //             ),
    //             title: "lorem ipsum",
    //             paragraph: "Developpeur React Native",
    //             texte:
    //                 "Lorem ipsum dolor sit amet consectetur.\nArcu consectetur fringilla gravida mauris.",
    //           ),
    //         ),
    //       ],
    //     ),
    //     Row(

    //       children: [
    //         Container(
    //           margin: const EdgeInsets.all(5),
    //           color: const Color.fromARGB(255, 101, 54, 244),
    //           width: 150,
    //           height: 150,
    //           child: carteReu(
    //             image: Image.asset(
    //               "lunette.jpg",
    //             ),
    //             title: "lorem ipsum",
    //             paragraph: "Developpeur React Native",
    //             texte:
    //                 "Lorem ipsum dolor sit amet consectetur.\nArcu consectetur fringilla gravida mauris.",
    //           ),
    //         ),
    //         Container(
    //           margin: const EdgeInsets.all(5),
    //           color: const Color.fromARGB(255, 101, 54, 244),
    //           width: 150,
    //           height: 150,
    //           child: carteReu(
    //             image: Image.asset(
    //               "t-shirt.jpg",
    //             ),
    //             title: "lorem ipsum",
    //             paragraph: "Developpeur React Native",
    //             texte:
    //                 "Lorem ipsum dolor sit amet consectetur.\nArcu consectetur fringilla gravida mauris.",
    //           ),
    //         ),
    //       ],
    //     ),
    //     SizedBox(height: 500),
    //   ],
    // );
  }
}
