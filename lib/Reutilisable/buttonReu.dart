// ignore: file_names
// Reutilisable/buttonReu.dart
import 'package:flutter/material.dart';

class BoutonR extends StatelessWidget {
  final String titre;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color? couleur;
  final double? width; // Ajouter une propriété de largeur

  // ignore: use_super_parameters
  const BoutonR({
    Key? key,
    required this.titre,
    required this.onPressed,
    this.borderRadius = 5,
    this.couleur,
    this.width, // Ajouter la propriété de largeur
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: couleur ?? Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 5), // Supprimer le padding horizontal
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: const Size(150, 0), 
      ),
      child: Text(
        titre,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF593070),
        ),
      ),
    );
  }
}
