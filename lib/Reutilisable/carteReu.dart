// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart' show Axis, BorderRadius, BoxDecoration, BuildContext, Color, Colors, Column, Container, EdgeInsets, Flexible, FontWeight, Image, Row, SingleChildScrollView, SizedBox, StatelessWidget, Text, TextStyle, Widget;
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
        width: 300,
        decoration: BoxDecoration(
      color: const Color.fromARGB(255, 85, 58, 112),
      borderRadius: BorderRadius.circular(borderRadius),
        ),
      
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(child: image, color: Colors.white,),
            Column(
              children: [
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 30)),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  // ignore: sort_child_properties_last
                  child: Text(paragraph,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 30)),
                  width: 100,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 25, bottom: 20, top: 5),
                    // ignore: sort_child_properties_last
                    child: Text(texte,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white)),
                    width: 180),
                BoutonR(
                  titre: "Ajouter au panier",
                  onPressed: () {
                    // Navigator.push(
                    //   contextr
                    //   // MaterialPageRoute(builder: (context) => carteReu()),
                    // );
      
                  },
                ),
                const SizedBox(
                  height: 20,
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
