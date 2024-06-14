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
              _buildImageContainer("assets/tissu-rayure.jpg"),
              _buildImageContainer("assets/wax-taille.jpg"),
              _buildImageContainer("assets/tailleur-vert-turquoise-foncé.jpg"),
              _buildImageContainer("assets/tailleur-beige.jpg"),
              _buildImageContainer("assets/samouraï-soie.jpg"),
              _buildImageContainer("assets/pantalon-soie.jpg"),
              _buildImageContainer("assets/Chemise-Corset.jpg"),
              _buildImageContainer("assets/chemise-ceinture-détachable-soie.jpg"),
              _buildImageContainer("assets/Bleu-pantalon.jpg"),
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

  Widget _buildImageContainer(String assetPath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 2.0,
          color: Colors.transparent, // Ajout de la couleur de bordure transparente
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.asset(
          assetPath,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
