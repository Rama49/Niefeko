import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

class Deal extends StatefulWidget {
  const Deal({Key? key}) : super(key: key);

  @override
  State<Deal> createState() => _DealState();
}

class _DealState extends State<Deal> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
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
                child: Row(
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
          SizedBox(height: 20),
          CarouselSlider(
            items: [
              //1st Image of Slider
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset("casque.png", fit: BoxFit.contain),
              ),
              //2nd Image of Slider
              Container(
                decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
              autoPlayAnimationDuration: Duration(milliseconds: 500),
              viewportFraction: 0.4, // Une image à la fois
            ),
          ),
        ],
      ),
    );
  }
}
