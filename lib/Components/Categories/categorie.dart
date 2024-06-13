import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Categorie extends StatefulWidget {
  const Categorie({Key? key}) : super(key: key);

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  // Méthode pour récupérer les catégories depuis l'API
  Future<void> fetchCategories() async {
    final url = Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/products/categories');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          categories = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final int halfLength = (categories.length / 2).ceil(); // Diviser la liste en deux parties

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: categories
                      .sublist(0, halfLength) // Prendre la première moitié des catégories
                      .map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0), // Ajout d'un espacement vertical
                      child: Text(
                        category['name'],
                        style: TextStyle(
                          fontSize: 20, // Taille de la police
                          color: Color(0xFF612C7D), // Couleur du texte
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: categories
                      .sublist(halfLength) // Prendre la deuxième moitié des catégories
                      .map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0), // Ajout d'un espacement vertical
                      child: Text(
                        category['name'],
                        style: TextStyle(
                          fontSize: 20, // Taille de la police
                          color: Color(0xFF612C7D), // Couleur du texte
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
