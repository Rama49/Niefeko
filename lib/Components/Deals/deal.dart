import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

// ignore: camel_case_types
class deal extends StatefulWidget {
  // ignore: use_super_parameters
  const deal({Key? key}) : super(key: key);

  @override
  State<deal> createState() => _dealState();
}

// ignore: camel_case_types
class _dealState extends State<deal> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20, right: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Special Vente",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(),
                    ),
                  );
                },
                child: const Row(
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
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CarouselSlider(
            items: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset("assets/casque.png", fit: BoxFit.contain),
              ),
              Container(
                decoration: const BoxDecoration(
                   borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset(
                  "assets/tshirtRouge.png",
                  width: 120,
                  height: 60,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                   borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset(
                  "assets/montre.png",
                  width: 120,
                  height: 60,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                   borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset(
                  "assets/sacoche.png",
                  width: 120,
                  height: 60,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                   borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  color: Color.fromARGB(255, 215, 194, 233),
                ),
                child: Image.asset(
                  "assets/pot.png",
                  width: 120,
                  height: 60,
                ),
              ),
            ],
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
              viewportFraction: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
