// ignore: file_names
// bouton_template.dart
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';

class BoutonR extends StatelessWidget {
  final String titre;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color? couleur;
  final double? fontSize;

  // ignore: use_super_parameters
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
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
      ),
      child: Text(
        titre,
        style: TextStyle(
          fontSize: fontSize ?? 16,
          color: const Color(0xFF593070),
        ),
      ),
    );
  }
}
