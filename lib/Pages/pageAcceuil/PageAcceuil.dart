import 'package:flutter/material.dart';
import 'package:niefeko/Components/Carte/Categories/categorie.dart';

class pageAcceuil extends StatelessWidget {
  const pageAcceuil({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [categorie()]);
  }
}