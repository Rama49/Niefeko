// bouton_template.dart
import 'package:flutter/material.dart';

class BoutonR extends StatelessWidget {
  final String titre;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color? couleur;
  final double? fontSize;

  const BoutonR({
    Key? key,
    required this.titre,
    required this.onPressed,
    this.borderRadius = 5,
    this.couleur,
    this.fontSize, // Ajouter la taille de police comme argument
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: couleur ?? Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
      ),
      child: Text(
        titre,
        style: TextStyle(
          fontSize: fontSize ?? 14,
          color: Color.fromARGB(255, 71, 3, 82),
        ),
      ),
    );
  }
}
