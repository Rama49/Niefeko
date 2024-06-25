import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

class CollectionHabit extends StatefulWidget {
  const CollectionHabit({super.key});

  @override
  _CollectionHabitState createState() => _CollectionHabitState();
}

class _CollectionHabitState extends State<CollectionHabit> {
  List<ProductCategory> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response = await http.get(
      Uri.parse(
          'https://niefeko.com/wp-json/custom-routes/v1/products/categories'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        categories =
            data.map((item) => ProductCategory.fromJson(item)).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CarouselSlider(
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
                        // Ajouter votre action ici
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
                              child: ClipOval(
                                child: Image.network(
                                  category.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 12.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
    );
  }
}

class ProductCategory {
  final String id;
  final String name;
  final String imageUrl;

  ProductCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'].toString(),
      name: json['name'] ?? 'No Name',
      imageUrl: json['image'] ?? 'https://via.placeholder.com/100', // Utilisez une image par défaut si nécessaire
    );
  }
}
