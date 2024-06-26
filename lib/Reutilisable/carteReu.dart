import 'package:flutter/material.dart';
import 'package:niefeko/Pages/SettingsPage/SettingsPage.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

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
          color: Color.fromARGB(255, 85, 58, 112),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    paragraph,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  width: 100,
                ),
                Container(
                  padding: EdgeInsets.only(left: 25, bottom: 20, top: 5),
                  child: Text(
                    texte,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  width: 180,
                ),
                BoutonR(
                  titre: "Ajouter au panier",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryPage()),
                    );
                  },
                ), // <-- Ajout de la virgule ici
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Flexible(child: image),
          ],
        ),
      ),
    );
  }
}
