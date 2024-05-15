// import 'package:flutter/material.dart';
// import 'package:niefeko/Components/Category/product.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
// import 'package:niefeko/Pages/Favoris/PageFavoris.dart';

// class CartProduit extends StatefulWidget{
//   final Product product;
//    CartProduit({super.key, required this.product});
//   @override
//   State<CartProduit> createState() => _CartProduit();
// }
// class _CartProduit extends State<CartProduit>{
//   List<bool> isFavoritedList = List.generate(20, (index) => false);
//   List<double> prices = [];
//   List<String> filteredImagePaths = [];
//   List<String> names = [];
//   List<String> imagePaths = [];
//   int cartItemCount = 0;
//   List<Product> cartItems = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredImagePaths.addAll(imagePaths);
//   }

//   void searchProduct(String query) {
//     setState(() {
//       filteredImagePaths = imagePaths
//           .where((path) => path.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   void addToCart(int index) {
//     // Récupérer les informations nécessaires
//     String imageUrl = imagePaths[index];
//     String productName = names[index];
//         //filteredImagePaths[index].split('/').last.split('.').first;
//     double price = prices[index];
//     DateTime timestamp = DateTime.now(); // Timestamp de la commande

//     // TODO: Récupérer l'ID du client, le prénom et le nom du client
//     String idClient = ""; // Remplir avec l'ID du client
//     String prenom = ""; // Remplir avec le prénom du client
//     String nom = ""; // Remplir avec le nom du client

//     // Calculer le montant total
//     double totalAmount = price * 1; // Pour l'exemple, mettons la quantité à 1

//     // Créer une instance de la commande
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
//         description: '',
//         price: price,
//       ));
//       cartItemCount++; // Incrémentez cartItemCount
//     });
//   }

//   void removeFromCart(int index) {
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

//   @override
//   Widget build(BuildContext context){
//     int index = 0;
//    //List<bool>isFavoritedList = List.generate(20, (index) => false,);
//     return SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//      width: MediaQuery.of(context).size.width / 2,
//     padding: const EdgeInsets.all(8),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(8.0),
//       color: Colors.grey.withOpacity(0.1),
//     ),
//     child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
            
//             IconButton(onPressed: (){

//             }, 
//             icon: Icon(Icons.favorite_border_outlined,
//             color: Colors.red,))
//             // IconButton(
//             //    onPressed: (){
//             //     setState(() {
//             //       isFavoritedList[index] = !isFavoritedList[index];
//             //     });

//             //     // Vérifiez si le produit est ajouté aux favoris
//             //     if (isFavoritedList[index]) {
//             //       //Créez une instance de produit
//             //       Product favoriteProduct = Product(
//             //         imagePath: widget.product.imagePath,
//             //         name: widget.product.name,
//             //         description: '',
//             //         price: widget.product.price,
//             //       );

//             //       // Ajouter le produit aux favoris dans Firestore
//             //       addFavoriteToFirestore(favoriteProduct);
//             //     }
//             //  }, 
//             //    icon: Icon(
//             //      isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
//             //     color: isFavoritedList[index] ? Colors.red : Colors.grey,
//             //   ),
             
//             //   )
            

//           ],
//         ),
//         SizedBox(
//           height: 120,
//           width: 120,
//           child: Image.asset(
//             widget.product.imagePath,
//             width: 90,
//             height: 90,
//             fit: BoxFit.cover,
//           ),
//         ),
//         SizedBox(height: 4),

//         Text(
//           widget.product.name,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.black,
//             fontWeight: FontWeight.bold
//           ),

//         ),
//         SizedBox(height: 4),
//         Text(
//           '${widget.product.price}',
//           style: TextStyle(
//             fontSize: 18,
//           fontWeight: FontWeight.bold, color: Colors.green),
//         ),
//         SizedBox(height: 8),
//         Center(
//           child: ElevatedButton(
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
//         )
//       ],
      
//     ),
//   )]
//   )
//   );

  
// }  
// // Méthode pour ajouter un produit aux favoris dans Firestore
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

//   }
  
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

