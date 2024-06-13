import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

class Categorie extends StatefulWidget {
  const Categorie({Key? key}) : super(key: key);

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<Map<String, dynamic>> categories = [];

  // Tableau des noms de catégories et de leurs images correspondantes
  final Map<String, String> categoryImages = {
    'collection femme': 'assets/collection-femme.jpg',
    'collection homme': 'assets/collection-homme.jpg',
    'cuisine & maison': 'assets/cuisine-&amp;-maison.jpg',
    'electroniques': 'assets/electroniques.jpg',
    'habillement': 'assets/habillement.jpg',
    'soins & bien être': 'assets/soins-&amp;-bien-être.jpg',
  };

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
          // Afficher les noms de catégories sur le terminal
          categories.forEach((category) {
            print(_decodeHtmlEntity(category['name']));
          });
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
          CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: false,
              autoPlay: false, // Désactiver le défilement automatique
              aspectRatio: 23 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
              viewportFraction: 0.25, // Une image à la fois
            ),
            items: categories.map((category) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 215, 194, 233),
                          ),
                          child: _buildCategoryImage(category['name']),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _decodeHtmlEntity(category['name'] ?? 'No Name'),
                          style: TextStyle(
                            fontSize: 10, // Ajuste la taille de la police
                            fontWeight: FontWeight.bold, // Texte en gras
                            color: Color(0xFF612C7D),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Méthode pour décoder les entités HTML dans les noms de catégories
  String _decodeHtmlEntity(String htmlString) {
    final document = htmlParser.parse(htmlString);
    if (document != null) {
      return document.body?.text ?? htmlString;
    } else {
      return htmlString;
    }
  }

  // Méthode pour nettoyer et normaliser les noms de catégories
  String _normalizeCategoryName(String categoryName) {
    return categoryName.toLowerCase()
      .replaceAll('&amp;', '&'); // Remplacer les entités HTML par des caractères normaux
  }

  // Méthode pour construire l'image de la catégorie en fonction du nom de la catégorie
  Widget _buildCategoryImage(String categoryName) {
    final cleanedCategoryName = _normalizeCategoryName(_decodeHtmlEntity(categoryName));
    final imagePath = categoryImages[cleanedCategoryName];
    return imagePath != null
        ? Image.asset(imagePath, fit: BoxFit.cover)
        : Image.asset('assets/tshirt1.jpg', fit: BoxFit.cover);
  }
}