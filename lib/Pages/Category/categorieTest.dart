// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:niefeko/Components/Category/MesProduits.dart';
// import 'package:niefeko/Components/Category/detail.dart';
// import 'package:niefeko/Components/Recherche/recherche.dart';
// import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
// import 'package:niefeko/Pages/Favoris/PageFavoris.dart';
// //import 'package:niefeko/Components/Category/MesProduits.dart';

// class Product {
//   final String imagePath;
//   final String name;
//   final String description;
//   final double price;

//   Product({required this.imagePath, required this.name, required this.description, required this.price});

//   // Convertir le produit en un map pour Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'imagePath': imagePath,
//       'name': name,
//       'description': description,
//       'price': price,
//     };
//   }
// }


// class Categorietest extends StatefulWidget {
//   @override
//   _CategorietestState createState() => _CategorietestState();
// }

// class _CategorietestState extends State<Categorietest> {
//   List<bool> isFavoritedList = List.generate(20, (index) => false);
//   int cartItemCount = 0;
//   List<Mesproduits> product = [];
//   List<String> imagePaths = [];
//   List<String> names = [];
//   List<String> descriptions = [];
//   List<double> prices = [];
//   List<Product> cartItems = [];
  
//   @override
//   void initState() {
//     super.initState();
//     names.addAll(imagePaths);
//   }

//   void searchProduct(String query) {
//     setState(() {
//       names = imagePaths
//           .where((path) => path.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   void addToCart(int index) {
//     // Récupérer les informations nécessaires
//     String imageUrl = imagePaths[index];
//     String productName = names[index];
//     String desProduct = descriptions[index];
//     double price = prices[index];
//     DateTime timestamp = DateTime.now(); // Timestamp de la commande

//     // TODO: Récupérer l'ID du client, le prénom et le nom du client
//     String idClient = ""; // Remplir avec l'ID du client
//     String prenom = ""; // Remplir avec le prénom du client
//     String nom = ""; // Remplir avec le nom du client

//     // Calculer le montant total
//     double totalAmount = price * 1; // Pour l'exemple, mettons la quantité à 1

// // Créer une instance de la commande
//     Order order = Order(
//       imageUrl: imageUrl,
//       idClient: idClient,
//       prenom: prenom,
//       nom: nom,
//       nomProduit: productName,
//       nbrProduit: 1, // Pour l'exemple, mettons la quantité à 1
//       prix: price,
//       totalAmount: totalAmount,
//       timestamp: timestamp,
//     );

//     // Ajouter la commande à Firestore
//     addOrderToFirestore(order);

//     setState(() {
//       cartItems.add(Product(
//         imagePath: imageUrl,
//         name: productName,
//         description: desProduct,
//         price: price,
//       ));
//       cartItemCount++; // Incrémentez cartItemCount
//     });
//   }

// void removeFromCart(int index) {
//     setState(() {
//       cartItems.removeAt(index);
//       cartItemCount--; // Décrémentez cartItemCount
//     });
//   }

//   void navigateToCartPage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CartPanier(
//           cartItems: cartItems,
//           removeFromCart: removeFromCart,
//         ),
//       ),
//     );
//   }

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF612C7D),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//          onPressed: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => search()),
//     );
//   },
//         ),
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
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
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               color: Color(0xFF612C7D),
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(7),
//                   color: Colors.white,
//                 ),
//                 child: TextField(
//                   onChanged: searchProduct,
//                   decoration: InputDecoration(
//                     hintText: 'Search...',
//                     prefixIcon: Icon(Icons.search, color: Colors.grey),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Container(
//                 padding: EdgeInsets.all(8.0),
//                 child: Row(
//                   children: List.generate(
//                     names.length,
//                     (index) => Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: AssetImage(names[index]),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             names.isEmpty
//                 ? Padding(
//                     padding: const EdgeInsets.all(8.0),
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
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemCount: names.length,
//                     itemBuilder: (context, index) {
//                       return buildCard(index);
//                     },
//                   ),
//           ],
//         ),
//       ),

 
//     );
//   }

//   Widget buildCard(int index) {
//     String names = imagePaths[index];
//     String imageName = names;
//     double price = prices[index];
//     return
//     Card(
//   child: GestureDetector(
//     onTap: () {

//  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => detail(),
//                    ),
//                  );
//  },
//     child: Stack(
//       children: 
//         [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 names[index],
//                 width: 90,
//                 height: 90,
//                 fit: BoxFit.cover,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       imageName,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       '\$$price',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.green),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 8),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () => addToCart(index),
//                   child: Row(
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
//             alignment: Alignment(1, -1),
//             child: IconButton(
//               icon: Icon(
//                 isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
//                 color: isFavoritedList[index] ? Colors.red : Colors.grey,
//               ),
//               onPressed: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => pageFavoris()),
//                 // );

//                 setState(() {
//                   isFavoritedList[index] = !isFavoritedList[index];
//                 });

//                 // Vérifiez si le produit est ajouté aux favoris
//                 if (isFavoritedList[index]) {
//                   // Créez une instance de produit
//                   Product favoriteProduct = Product(
//                     imagePath: imagePaths[index],
//                     name: imageName,
//                     description: descriptions[index],
//                     price: price,
//                   );

//                   // Ajouter le produit aux favoris dans Firestore
//                   addFavoriteToFirestore(favoriteProduct);
//                 }
//               },
//             ),
//           ),
//         ],
      
//     ),
//   ),
// );

//   }

//   // Méthode pour ajouter un produit aux favoris dans Firestore
//   void addFavoriteToFirestore(Product favoriteProduct) {
//     // Référence à la collection "favorites" dans Firestore
//     CollectionReference favorites =
//         FirebaseFirestore.instance.collection('favoris');

//     // Ajouter le produit aux favoris dans Firestore
//     favorites
//         .add(favoriteProduct.toMap())
//         .then((value) =>
//             print("Produit ajouté aux favoris avec l'ID: ${value.id}"))
//         .catchError(
//             (error) => print("Erreur lors de l'ajout aux favoris: $error"));
//   }

//   void addOrderToFirestore(Order order) {
//     // Référence à la collection "orders" dans Firestore
//     CollectionReference orders =
//         FirebaseFirestore.instance.collection('Panier');

//     // Ajouter la commande à Firestore
//     orders
//         .add(order.toMap())
//         .then((value) => print("Commande ajoutée avec l'ID: ${value.id}"))
//         .catchError(
//             (error) => print("Erreur lors de l'ajout de la commande: $error"));
//   }
// }

// class Order {
//   final String imageUrl;
//   final String idClient;
//   final String prenom;
//   final String nom;
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
//       'nomProduit': nomProduit,
//       'nbrProduit': nbrProduit,
//       'prix': prix,
//       'totalAmount': totalAmount,
//       'timestamp': timestamp,
//     };
//   }


// }