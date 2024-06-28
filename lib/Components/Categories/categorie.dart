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
    final url = Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/products/categories');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          categories = List<Map<String, dynamic>>.from(data);
          // Ajouter les images pour chaque catégorie si elles ne sont pas fournies par l'API
          categories.forEach((category) {
            final cleanedCategoryName = _normalizeCategoryName(_decodeHtmlEntity(category['name']));
            if (!categoryImages.containsKey(cleanedCategoryName)) {
              categoryImages[cleanedCategoryName] = 'https://niefeko.com/wp-content/uploads/2024/06/Ensemble-Haut-Bleu-et-pantalon-.jpg';
            }
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
                  return GestureDetector(
                    onTap: () {
                      final categoryId = category['id'];
                      final categoryName = _decodeHtmlEntity(category['name']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryDetailPage(
                            categoryId: categoryId.toString(),
                            categoryName: categoryName,
                          ),
                        ),
                      );
                    },
                    child: Container(
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

  String _decodeHtmlEntity(String htmlString) {
    final document = htmlParser.parse(htmlString);
    return document.body?.text ?? htmlString;
  }

  String _normalizeCategoryName(String categoryName) {
    return categoryName.toLowerCase().replaceAll('&amp;', '&');
  }

  Widget _buildCategoryImage(String categoryName) {
    final cleanedCategoryName = _normalizeCategoryName(_decodeHtmlEntity(categoryName));
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

class CategoryDetailPage extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CategoryDetailPage({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/products?category=${widget.categoryId}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          products = data;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  child: ListTile(
                    title: Text(product['name'] ?? 'No Name'),
                    subtitle: Text(product['description'] ?? 'No Description'),
                    // Ajoutez d'autres détails de produit si nécessaire
                    // en fonction de la structure de réponse de l'API
                  ),
                );
              },
            ),
    );
  }
}
