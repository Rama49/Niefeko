import 'package:flutter/material.dart';
import 'package:niefeko/Components/Carte/recherche/recherche.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';

class carteReu extends StatelessWidget {
  final Image image;
  final String title;
  final String paragraph;
  final String texte;

  const carteReu(
      {super.key,
      required this.image,
      required this.title,
      required this.paragraph,
      required this.texte});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 85, 58, 112),
      height: 200,
      width: 450,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(child: image),
          // Container(child: image, color: Colors.white,),
          Column(
            children: [
              Container(
                child: Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 30)),
              ),
              Container(
                child: Text(paragraph,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 30)),
                width: 100,
              ),
              Container(
                  child: Text(texte,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  width: 180),
                  SizedBox(height: 10,),
                 BoutonR(
  titre: "Ajouter au panier",
  onPressed: () {
    // Navigator.push(
    //   context
    //   // MaterialPageRoute(builder: (context) => carteReu()),
    // );
  },
),
SizedBox(height: 20,)




            ],
          )
        ],
      ),
    );
  }
}
