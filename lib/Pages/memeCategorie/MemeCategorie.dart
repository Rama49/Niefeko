// import 'package:firebase_auth/firebase_auth.dart';
// //import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:niefeko/Components/Category/MesProduits.dart';
// import 'package:niefeko/Pages/Category/detail.dart';
// import 'package:niefeko/Pages/Recherche/recherche.dart';
// import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
// import 'package:niefeko/Components/Category/product.dart';

// class MemeCategorie extends StatefulWidget {
//   @override
//   // ignore: library_private_types_in_public_api
//   _CategoryPageState createState() => _CategoryPageState();
// }

// class _CategoryPageState extends State<MemeCategorie> {
//   List<bool> isFavoritedList = List.generate(20, (index) => false);
//   List<double> prices = [];
//   List<String> filteredImagePaths = [];
//   List<Product> filteredProducts = [];
//   String selectedCategory = 'chaussures';
  
//   get navigateToCartPage => null;
  
//   get cartItemCount => null;
  
//   get searchProduct => null; // Exemple de catégorie sélectionnée

//   @override
//   void initState() {
//     super.initState();
//     filterProductsByCategory(selectedCategory); // Filtrer les produits par catégorie au démarrage
//   }

//   void filterProductsByCategory(String category) {
//     setState(() {
//       filteredProducts = MesProduits.allProducts
//           .where((product) => product.category == category)
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF612C7D),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF612C7D),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => search()),
//             );
//           },
//         ),
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.shopping_cart, color: Colors.white, size: 40),
//                 onPressed: navigateToCartPage,
//               ),
//               Positioned(
//                 right: 8,
//                 top: 8,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.red,
//                   radius: 10,
//                   child: Text(
//                     cartItemCount.toString(),
//                     style: const TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               color: const Color(0xFF612C7D),
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(7),
//                   color: Colors.white,
//                 ),
//                 child: TextField(
//                   onChanged: searchProduct,
//                   decoration: const InputDecoration(
//                     hintText: 'Search...',
//                     prefixIcon: Icon(Icons.search, color: Colors.grey),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             filteredProducts.isEmpty
//                 ? const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       "Produit non trouvé",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: Colors.red,
//                       ),
//                     ),
//                   )
//                 : GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemCount: filteredProducts.length,
//                     itemBuilder: (context, index) {
//                       final product = filteredProducts[index];
//                       return GestureDetector(
//                         onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Detail(
//                               product: product,
//                             ),
//                           ),
//                         ),
//                         child: buildCard(index, product),
//                       );
//                     }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildCard(int index, Product product) {
//     return Card(
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 product.imagePath,
//                 fit: BoxFit.cover,
//               ),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () => addToCart(product),
//                   child: const Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'Ajouter au',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                       Icon(Icons.shopping_cart, color: Colors.white),
//                     ],
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     backgroundColor: Color(0xFF612C7D),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(7),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: const Alignment(1, -1),
//             child: IconButton(
//               icon: Icon(
//                 isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
//                 color: isFavoritedList[index] ? Colors.red : Colors.grey,
//               ),
//               onPressed: () {
//                 setState(() {
//                   isFavoritedList[index] = !isFavoritedList[index];
//                 });

//                 if (isFavoritedList[index]) {
//                   Product favoriteProduct = Product(
//                     imagePath: product.imagePath,
//                     name: product.name,
//                     description: 'ma description',
//                     price: product.price,
//                     category: product.category,
//                   );

//                   addFavoriteToFirestore(favoriteProduct);
//                   showAddToFavoritesDialog(context, product.name);
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void addFavoriteToFirestore(Product favoriteProduct) {
//     CollectionReference favorites =
//         FirebaseFirestore.instance.collection('favoris');

//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       print("L'utilisateur n'est pas connecté.");
//       return;
//     }

//     String userID = user.uid;

//     favorites
//         .add({
//           ...favoriteProduct.toMap(),
//           'userID': userID,
//         })
//         .then((value) =>
//             print("Produit ajouté aux favoris avec l'ID: ${value.id}"))
//         .catchError(
//             (error) => print("Erreur lors de l'ajout aux favoris: $error"));
//   }

//   void showAddToFavoritesDialog(BuildContext context, String productName) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Produit ajouté aux favoris'),
//           content: Text('$productName a été ajouté à vos favoris.'),
//           actions: [
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
  
//   addToCart(Product product) {}
// }

// class Order {
//   final String imageUrl;
//   final String idClient;
//   final String prenom;
//   final String nom;
//   final String email;
//   final String nomProduit;
//   final int nbrProduit;
//   final double prix;
//   final double totalAmount;
//   final DateTime timestamp;

//   Order({
//     required this.imageUrl,
//     required this.idClient,
//     required this.prenom,
//     required this.nom,
//     required this.email,
//     required this.nomProduit,
//     required this.nbrProduit,
//     required this.prix,
//     required this.totalAmount,
//     required this.timestamp,
//   });

//   // Convertir la commande en un map pour Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'imageUrl': imageUrl,
//       'idClient': idClient,
//       'prenom': prenom,
//       'nom': nom,
//       'email': email,
//       'nomProduit': nomProduit,
//       'nbrProduit': nbrProduit,
//       'prix': prix,
//       'totalAmount': totalAmount,
//       'timestamp': timestamp,
//     };
//   }
// }
