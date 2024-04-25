import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class deal extends StatefulWidget {
  const deal({super.key});

  @override
  State<deal> createState() => _dealState();
}

class _dealState extends State<deal> {
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
                "Special Vente",
                style: TextStyle(
                  fontSize: 30,
                ),
              )
            ],
          ),
          // SizedBox(height: 10),
          CarouselSlider(
            items: [
              //1st Image of Slider
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset(
                  "casque.png",
                  fit: BoxFit.contain
                ),
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
          // SizedBox(height: 500)
        ],
      ),
    );
  }
}