import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class categorie extends StatefulWidget {
  const categorie({super.key});

  @override
  State<categorie> createState() => _categorieState();
}

class _categorieState extends State<categorie> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              )
            ],
          ),
          CarouselSlider(
            items: [
              //1st Image of Slider
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                        const Radius.circular(40.0),
                      ),
                  color: Color.fromARGB(255, 178, 126, 231),
                ),
                child: Image.asset(
                  "gourde.png",
                  width: 120,
                  height: 60,
                ),
              ),
              //2nd Image of Slider
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                        const Radius.circular(40.0),
                      ),
                  color: Color.fromARGB(255, 178, 126, 231),
                ),
                child: Image.asset(
                  "pantalon.png",
                  width: 120,
                  height: 60,
                ),
              ),
              //3rd Image of Slider
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                        const Radius.circular(40.0),
                      ),
                  color: Color.fromARGB(255, 178, 126, 231),
                ),
                child: Image.asset(
                  "lunnete1.png",
                  width: 120,
                  height: 60,
                ),
              ),
              //4th Image of Slider
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                        const Radius.circular(40.0),
                      ),
                  color: Color.fromARGB(255, 178, 126, 231),
                ),
                child: Image.asset(
                  "torche.png",
                  width: 120,
                  height: 60,
                ),
              ),
              //5th Image of Slider
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                        const Radius.circular(40.0),
                      ),
                  color: Color.fromARGB(255, 178, 126, 231),
                ),
                child: Image.asset(
                  "maronshoes.png",
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
