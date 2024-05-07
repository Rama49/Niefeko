// Reutilisable/carteReu.dart
import 'package:flutter/material.dart';import 'package:flutter/material.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';

class CarteReu extends StatelessWidget {
  final Image image;
  final String title;
  final String paragraph;
  final String texte;
  final double borderRadius;

  const CarteReu({
    Key? key,
    required this.image,
    this.borderRadius = 20,
    required this.title,
    required this.paragraph,
    required this.texte,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 85, 58, 112),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                    paragraph,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Text(
                    texte,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: BoutonR(
                    titre: "Ajouter au panier",
                    onPressed: () {
                      // Ajouter la logique pour ajouter au panier
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            Flexible(child: image),
          ],
        ),
      ),
    );
  }
}
