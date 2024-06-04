// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:niefeko/Pages/PanierHistorique/PanierPage.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';

// ignore: camel_case_types
class carteReu extends StatelessWidget {
  final Image image;
  final String title;
  final String paragraph;
  final String texte;
  final double borderRadius;

  const carteReu(
      {super.key,
      required this.image,
      this.borderRadius = 20,
      required this.title,
      required this.paragraph,
      required this.texte});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 85, 58, 112),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Colors.grey, // Couleur de la bordure
            width: 2.0, // Épaisseur de la bordure
          ),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  child: Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 30)),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(paragraph,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 25)),
                  width: 100,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 2, bottom: 2, top: 5),
                    child: Text(texte,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white)),
                    width: 180),
                BoutonR(
                  titre: "Ajouter au panier",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PanierPage()),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
            Flexible(child: image),
          ],
        ),
      ),
    );
  }
}
