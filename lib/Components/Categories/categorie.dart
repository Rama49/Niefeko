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
              autoPlay: true,
              enlargeCenterPage: false,
              aspectRatio: 2.0,
              autoPlayInterval: Duration(seconds: 10),  // Augmenter la durée de l'intervalle
            ),
            items: categories.map((category) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5.0), // Ajuste la marge horizontale
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
                          child: category['image_url'] != null
                              ? Image.network(
                                  category['image_url'],
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/jordan.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _decodeHtmlEntity(category['name'] ?? 'No Name'),
                          style: TextStyle(
                            fontSize: 20,
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
}
