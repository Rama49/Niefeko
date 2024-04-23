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
    return 
    Container(
      child: Column(
        children: [
          Text(
            "feeeeeeeeeeeeee",
            style: TextStyle(
              fontSize: 30,
            ),
          ), CarouselSlider(
          items: [
            //1st Image of Slider
            Column(children: [
              Flexible(
                child: Image.asset(
                  "sac.png",
                  color: Colors.amber,
                  width: 100,
                  height: 100,
                ),
              ),
            ]),
        
            //2nd Image of Slider
            Column(children: [
              Flexible(
                child: Image.asset(
                  "lunette.png",
                 width: 100,
                  height: 100,
                ),
              ),
            ]),
        
            //3rd Image of Slider
            Column(children: [
              Flexible(
                child: Image.asset(
                  "shoes.png",
                  width: 100,
                  height: 100,
                ),
              ),
            ]),
        
            //4th Image of Slider
            Column(children: [
              Flexible(
                child: Image.asset(
                  "t-shirt.png",
                  width: 100,
                  height: 100,
                ),
              ),
            ]),
        
            //5th Image of Slider
            Column(children: [
              Flexible(
                child: Image.asset(
                  "sac.png",
                  width: 100,
                  height: 100,
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
        ),],
      ),
    );
  }
}
