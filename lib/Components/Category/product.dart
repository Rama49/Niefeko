import 'dart:convert';

class Product {
  final String imagePath;
  final String name;
  final String description;
  final double price;
  final int id;
  int quantity; // Peut-être supprimé si non utilisé globalement.

  Product({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    required this.id,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'imagePath': imagePath,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
      // Vérifiez si 'image' existe et contient 'url'
      imagePath: json['images'] != null && json['images'].isNotEmpty && json['images'][0]['src'] != null
          ? json['images'][0]['src']
          : 'https://via.placeholder.com/150', // URL d'une image placeholder par défaut
    );
  }
}
