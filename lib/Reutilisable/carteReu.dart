import 'package:flutter/material.dart';

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
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image,
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          Container(padding: EdgeInsets.only(left: 20), child: Text(paragraph)),
          SizedBox(height: 20),
          Container(padding: EdgeInsets.only(left: 20), child: Text(texte)),
        ],
      ),
    );
  }
}
