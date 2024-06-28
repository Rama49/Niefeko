// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:http/http.dart' as http;
// import 'package:niefeko/Components/Category/product.dart';
// import 'package:niefeko/Pages/CartPanier/CartPanier.dart';

// class ProductDetailPage extends StatefulWidget {
//   final int productId;

//   ProductDetailPage({required this.productId});

//   @override
//   _ProductDetailPageState createState() => _ProductDetailPageState();
// }

// class _ProductDetailPageState extends State<ProductDetailPage> {
//   late Product product;

//   @override
//   void initState() {
//     super.initState();
//     getProductDetails(widget.productId);
//   }

//   Future<void> getProductDetails(int productId) async {
//     final response = await http.post(
//       Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/products'),
//       body: json.encode({"id": productId.toString()}),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       setState(() {
//         product = Product.fromJson(responseData);
//       });
//     } else {
//       print('Failed to load product details: ${response.statusCode}');
//       throw Exception('Failed to load product details');
//     }
//   }

//   void addToCart(Product product) async {
//     final cartItem = product.toJson(); // Utilisation de `toJson()` pour obtenir la représentation en Map

//     // Vous pouvez ajouter des éléments supplémentaires à cartItem comme la quantité, par exemple
//     // cartItem['quantity'] = 1;

//     // Exemple de navigation vers le panier après l'ajout
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CartPanier(
//           cartItems: [cartItem], // Ajoutez ici l'élément au panier
//           user_firstname: "",
//           user_lastname: "",
//           user_email: "",
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Détails du Produit'),
//       ),
//       body: product != null
//           ? SingleChildScrollView(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Affichage de toutes les images détaillées du produit
//                   if (product.imagesDetail.isNotEmpty)
//                     Column(
//                       children: product.imagesDetail.map((image) {
//                         return Image.network(
//                           image,
//                           height: 300,
//                           width: double.infinity,
//                           errorBuilder: (context, error, stackTrace) =>
//                               Image.asset(
//                                 'assets/default_image.jpg',
//                                 height: 300,
//                                 width: double.infinity,
//                               ),
//                         );
//                       }).toList(),
//                     ),
//                   SizedBox(height: 16),
//                   Text(
//                     product.name,
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Html(data: product.description),
//                   SizedBox(height: 8),
//                   Text(
//                     'Prix: ${product.price} FCFA',
//                     style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       addToCart(product); // Appel de la méthode d'ajout au panier
//                     },
//                     child: Text('Ajouter au panier'),
//                   ),
//                 ],
//               ),
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }
