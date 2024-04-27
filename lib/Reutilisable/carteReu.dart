import 'package:flutter/material.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';

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
    return Container(
      width: 300,
      decoration: BoxDecoration(
    color: Color.fromARGB(255, 85, 58, 112),
    borderRadius: BorderRadius.circular(borderRadius),
      ),
    
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                padding: EdgeInsets.only(left: 5),
                child: Text(paragraph,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 30)),
                width: 100,
              ),
              Container(
                  padding: EdgeInsets.only(left: 25, bottom: 20, top: 5),
                  child: Text(texte,
                      style: TextStyle(
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
              SizedBox(
                height: 20,
              )
            ],
          ),
          Expanded(child: image),
        ],
      ),
    );
  }
}
