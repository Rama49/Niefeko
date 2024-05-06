import 'package:flutter/material.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';

class carteReu extends StatelessWidget {
  final Image image;
  final String title;
  final String paragraph;
  final String texte;
  final double borderRadius;

  const carteReu({
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
                          fontSize: 30)),
                  width: 100,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25, bottom: 20, top: 5),
                  child: Text(texte,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white)),
                  width: 180,
                ),
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
            Expanded(child: image),
          ],
        ),
      ),
    );
  }
}
