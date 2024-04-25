// import 'package:flutter/material.dart';

// class CategorieBody extends StatelessWidget {
//   const CategorieBody({Key? key, required List<String> imageUrls}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Dummy product data
//     List<Map<String, dynamic>> products = List.generate(
//       8,
//       (index) => {
//         'imageUrl': 'https://via.placeholder.com/150',
//         'productName': 'Product $index',
//         'price': 20.0,
//       },
//     );

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Determine le nombre de colonnes en fonction de la largeur de l'écran
//         int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;

//         return GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: crossAxisCount,
//             crossAxisSpacing: 8.0,
//             mainAxisSpacing: 8.0,
//           ),
//           itemCount: products.length,
//           itemBuilder: (context, index) {
//             final product = products[index];
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Product image
//                     Image.network(
//                       product['imageUrl'],
//                       width: 150,
//                       height: 150,
//                       fit: BoxFit.cover,
//                     ),
//                     SizedBox(height: 8),
//                     // Heart icon in top right corner
//                     Positioned(
//                       top: 8,
//                       right: 8,
//                       child: Icon(
//                         Icons.favorite,
//                         color: Colors.red,
//                       ),
//                     ),
//                     // Product name
//                     Text(
//                       product['productName'],
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     // Product price
//                     Text(
//                       '\$${product['price']}',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.green,
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     // Buy button
//                     ElevatedButton(
//                       onPressed: () {
//                         // Action when buy button is pressed
//                       },
//                       child: Text('Acheter'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class CategorieHeader extends StatelessWidget {
//   final List<String> imageUrls = [
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//     '../assets/tshirt1.jpg',
//   ];

//   CategorieHeader({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green, // Couleur verte de la barre d'en-tête
//         iconTheme: IconThemeData(color: Colors.white), // Couleur blanche pour les icônes
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // Retour à la page précédente
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.shopping_cart),
//             onPressed: () {
//               // Gérer l'action du panier ici
//             },
//           ),
//         ],
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(70), // Hauteur de la barre de recherche avec marge supérieure
//           child: Center( // Centrer la barre de recherche
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), // Ajout de la marge supérieure
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white, // Couleur de fond blanche
//                         borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
//                         border: Border.all(color: Colors.grey), // Bordure grise
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0), // Ajouter un peu de marge horizontale
//                         child: TextField(
//                           style: TextStyle(color: Colors.black), // Couleur du texte entré en noir
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.search, color: Colors.grey), // Icône de recherche en gris
//                             hintText: 'Rechercher un produit', // Texte placeholder
//                             hintStyle: TextStyle(color: Colors.grey), // Couleur du texte placeholder en gris
//                             border: InputBorder.none, // Supprimer la bordure
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: CategorieBody(), // Utilisation du nouveau container CategorieBody
//     );
//   }
// }
