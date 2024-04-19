import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class carte extends StatefulWidget {
  const carte({super.key});

  @override
  State<carte> createState() => _carteState();
}

class _carteState extends State<carte> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: [
          //1st Image of Slider
          Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage('sac.jpg'),
                fit: BoxFit.cover,
              ),
            ),
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
          ),

          //2nd Image of Slider
          Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage('lunette.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //3rd Image of Slider
          Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage('shoes.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //4th Image of Slider
          Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage('t-shirt.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 200),
          //5th Image of Slider
          Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage('sac.jpg'),
                fit: BoxFit.cover,
              ),
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
