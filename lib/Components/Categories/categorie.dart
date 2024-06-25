import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:niefeko/Pages/Collection/Collectionhabi.dart';
import 'package:niefeko/Pages/SettingsPage/SettingsPage.dart';

class Categorie extends StatefulWidget {
  const Categorie({Key? key}) : super(key: key);

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<Map<String, dynamic>> categories = [];

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

  Future<void> fetchCategories() async {
    final url = Uri.parse(
        'https://niefeko.com/wp-json/custom-routes/v1/products/categories');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          categories = List<Map<String, dynamic>>.from(data);
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
          GestureDetector(
            child: CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: false,
                autoPlay: false,
                aspectRatio: 23 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                viewportFraction: 0.25,
              ),
              items: categories.map((category) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 215, 194, 233),
                            ),
                            child: ClipOval(
                              child: _buildCategoryImage(category['name']),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Flexible(
                            child: Text(
                              _decodeHtmlEntity(category['name'] ?? 'No Name'),
                              style: TextStyle(
                                fontSize: 12.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _decodeHtmlEntity(String htmlString) {
    final document = htmlParser.parse(htmlString);
    if (document != null) {
      return document.body?.text ?? htmlString;
    } else {
      return htmlString;
    }
  }

  String _normalizeCategoryName(String categoryName) {
    return categoryName.toLowerCase().replaceAll('&amp;', '&');
  }

  Widget _buildCategoryImage(String categoryName) {
    final cleanedCategoryName =
        _normalizeCategoryName(_decodeHtmlEntity(categoryName));
    final imagePath = categoryImages[cleanedCategoryName];
    return imagePath != null
        ? Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: 70,
            height: 70,
          )
        : Image.asset(
            'assets/casque.png',
            width: 70,
            height: 70,
          );
  }
}
