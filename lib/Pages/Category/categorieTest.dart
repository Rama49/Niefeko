// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ProductCategory {
//   final int id;
//   final String name;

//   ProductCategory({required this.id, required this.name});
// }

// class ProductListScreen extends StatefulWidget {
//   @override
//   _ProductListScreenState createState() => _ProductListScreenState();
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   List<ProductCategory> _categories = [];


//   @override
//   void initState() {
//     super.initState();
//     _fetchCategories();
//   }

//   Future<void> _fetchCategories() async {
//     final response = await http.get(Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/products/categories'));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       setState(() {
//         _categories = data.map((json) => ProductCategory(
//           id: json['id'],
//           name: json['name'],
//         )).toList();
//       });
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: _categories.length,
//         itemBuilder: (context, index) {
//           final category = _categories[index];
//           return ListTile(
//             title: Text(category.name),
//             onTap: () {
//               _fetchCategories();
//             },
//           );
//         },
//       ),
//     );
//   }
// }
