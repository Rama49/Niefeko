// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// //import 'package:niefeko/Components/Deals/deal.dart';

// class Fournisseur{
//   final int id;
//   final String name;
//   //final double price;
//   final String description;
//   final String imagePath;

//   Fournisseur({required this.id, required this.name, required this.description, required this.imagePath});
//   factory Fournisseur.fromJson(Map<String, dynamic> json) {
//     return Fournisseur(
//       id: json['id'],
//       name: json['name'], 
//       description: json['description'],
//       imagePath: json['imagePath']
//     );
//   }

// }

 
// class product extends StatelessWidget {
//    const product({super.key});
//    //State<product> createState() => _productState();

// //class _productState extends State<product>{
// Future<List<Fournisseur>> fetchFournisseurs() async {
//   final response = await http.get(Uri.parse('https://niefeko.com/wp-json/dokan/v1/stores'));
  
//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     return data.map((json) => Fournisseur.fromJson(json)).toList();
//   } else {
//     throw Exception('Échec de chargement des fournisseurs');
//   }
// }

//      @override
//      Widget build(BuildContext context) {
//       return FutureBuilder<List<Fournisseur>>(
//           future: fetchFournisseurs(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Erreur : ${snapshot.error}'));
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(snapshot.data![index].name),
//                     leading: Text(snapshot.data![index].imagePath),
//                     subtitle: Text(snapshot.data![index].description),
//                   );
//                 },
//               );
//             }
//           },
//         );
//   }

// }
