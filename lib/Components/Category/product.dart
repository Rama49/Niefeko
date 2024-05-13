//import 'package:flutter/material.dart';

class Product {
  //final int id; 
  final String imagePath, name, description;
  final double price;
  int quantity;

  // Product( {
  //   //  required this.id,
  //     required this.imagePath,
  //     required this.name,
  //     required this.description,
  //     required this.price,
  //     });
       Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'name': name,
      'desciption': description,
      'price': price,
    };
    }

  Product({
      required this.imagePath,
      required this.name,
      required this.price,
      required this.description,
      this.quantity = 1,
    });
}
