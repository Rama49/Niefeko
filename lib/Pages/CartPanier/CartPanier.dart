// Reutilisable/carteReu.dart
import 'package:flutter/material.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';

class carteReu extends StatelessWidget {
  final Image image;
  final String title;
  final String paragraph;
  final String texte;
  final VoidCallback onButtonPressed;
  final Color backgroundColor;

  const carteReu({
    Key? key,
    required this.image,
    required this.title,
    required this.paragraph,
    required this.texte,
    required this.onButtonPressed,
    this.backgroundColor = const Color(0xFF593070), // Default color mauve
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Expanded(child: image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color to contrast the background
                  ),
                ),
                Text(paragraph, style: const TextStyle(color: Colors.white)),
                Text(texte, style: const TextStyle(color: Colors.white)),
                BoutonR(
                  titre: "Ajouter",
                  onPressed: onButtonPressed,
                  couleur: Colors.white, // Custom color for the button
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
