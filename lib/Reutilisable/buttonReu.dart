// ignore: file_names
import 'package:flutter/material.dart';

class BoutonR extends StatelessWidget {
  final String titre;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color? couleur;
  final double? width;

  const BoutonR({
    Key? key,
    required this.titre,
    required this.onPressed,
    this.borderRadius = 5,
    this.couleur,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: couleur ?? Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          titre,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF593070),
          ),
        ),
      ),
    );
  }
}
