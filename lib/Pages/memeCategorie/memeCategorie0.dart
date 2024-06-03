import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:niefeko/Components/Category/MesProduits.dart';
import 'package:niefeko/Pages/Category/detail.dart';
import 'package:niefeko/Pages/Recherche/recherche.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
import 'package:niefeko/Components/Category/product.dart';

class MemeCategorie0 extends StatefulWidget {
  @override
  _MemeCategoryPageState createState() => _MemeCategoryPageState();
}

class _MemeCategoryPageState extends State<MemeCategorie0> {
  List<bool> isFavoritedList = List.generate(20, (index) => false);
  List<double> prices = [];
  List<String> filteredImagePaths = [];
  //List<String> names = [];
  List<String> imagePaths = [
    'assets/casque.png',
    'assets/chaussure.png',
    'assets/coquillage.png',
    'assets/gourde.png',
    'assets/jordan.png',
    'assets/lunnete1.png',
    'assets/lunette.png',
    'assets/montre.png',
    'assets/pantalon.png',
    'assets/pot.png',
    'assets/sac1.png',
    'assets/sac.jpg',
    'assets/sacoche.png',
    'assets/shoes.png',
    'assets/t-shirt.png',
    'assets/torche.png',
    'assets/tshirt-polo.jpg',
    'assets/tshirt1.jpg',
    'assets/tshirtRouge.png',
    'assets/torche.png',
  ];
  int cartItemCount = 0;
  List<Product> cartItems = [];

  @override
  void initState() {
    super.initState();
    filteredImagePaths.addAll(imagePaths);
  }

  void searchProduct(String query) {
    setState(() {
      filteredImagePaths = imagePaths
          .where((path) => path.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // Ajouter une logique pour rechercher dans les noms de produits
      List<String> filteredProducts = MesProduits.allProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .map((product) => product.imagePath)
          .toList();

      // Ajouter les produits filtrés à la liste des images filtrées
      filteredImagePaths.addAll(filteredProducts);

      // Supprimer les doublons de la liste des images filtrées
      filteredImagePaths = filteredImagePaths.toSet().toList();
    });
  }

  void addToCart(Product product) async {
    String imageUrl = product.imagePath;
    String productName = product.name;
    double price = product.price;
    DateTime timestamp = DateTime.now(); // Timestamp de la commande

    // Vérifier si le produit existe déjà dans le panier
    int existingIndex =
        cartItems.indexWhere((product) => product.name == productName);
    if (existingIndex != -1) {
      // Le produit existe déjà dans le panier, augmentez simplement la quantité
      setState(() {
        cartItems[existingIndex].quantity++; // Augmenter la quantité du produit
        cartItemCount++; // Augmenter le nombre total d'articles dans le panier
      });
    } else {
      // Le produit n'existe pas encore dans le panier, l'ajouter
      setState(() {
        cartItems.add(Product(
          imagePath: imageUrl,
          name: productName,
          description: 'description',
          price: price,
          quantity: 1, // Initialiser la quantité à 1
        ));
        cartItemCount++; // Augmenter le nombre total d'articles dans le panier
      });
    }

    // Show an alert dialog after adding the product to the cart
    showAddToCartDialog(context, productName);
  }

  void showAddToCartDialog(BuildContext context, String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Produit ajouté'),
          content: Text('$productName a été ajouté à votre panier.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
      cartItemCount--;
    });
  }

  Future<void> navigateToCartPage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Redirection vers la page de connexion si l'utilisateur n'est pas connecté
      // Vous pouvez implémenter cela selon vos besoins
      return;
    }

    String userID = user.uid;
    String email = user.email!;

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Inscription')
        .doc(userID)
        .get();

    String prenom = userSnapshot['prenom'];
    String nom = userSnapshot['nom'];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPanier(
          cartItems: cartItems,
          removeFromCart: removeFromCart,
          idClient: userID,
          prenom: prenom,
          nom: nom, // Passer la valeur de nom
          email: email,
          validateCart: validateCart,
        ),
      ),
    );
  }

  void validateCart(
      BuildContext context, String idClient, String prenom, String nom) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Redirection vers la page de connexion si l'utilisateur n'est pas connecté
      // Vous pouvez implémenter cela selon vos besoins
      return;
    }

    String userID = user.uid;

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Inscription')
        .doc(userID)
        .get();

    String prenom = userSnapshot['prenom'];
    String nom = userSnapshot['nom'];
    String email = userSnapshot[
        'email']; // Si l'email est stocké dans la collection "Inscription"

    // ignore: avoid_function_literals_in_foreach_calls
    cartItems.forEach((product) {
      String imageUrl = product.imagePath;
      String productName = product.name;
      double price = product.price;
      DateTime timestamp = DateTime.now();

      double totalAmount = price *
          product
              .quantity; // Calculer le montant total en multipliant le prix par la quantité

      Order order = Order(
        imageUrl: imageUrl,
        idClient: userID,
        prenom: prenom,
        nom: nom,
        email: email,
        nomProduit: productName,
        nbrProduit: product.quantity, // Utiliser la quantité du produit
        prix: price,
        totalAmount: totalAmount,
        timestamp: timestamp,
      );

      addOrderToFirestore(order);
    });

    setState(() {
      cartItems.clear();
      cartItemCount = 0;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Panier validé'),
        content: const Text('Votre panier a été validé avec succès.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void addOrderToFirestore(Order order) {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('Panier');

    orders
        .add(order.toMap())
        // ignore: avoid_print
        .then((value) => print("Commande ajoutée avec l'ID: ${value.id}"))
        .catchError((error) =>
            // ignore: avoid_print
            print("Erreur lors de l'ajout de la commande: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF612C7D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => search()),
            );
          },
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white, size: 40),
                onPressed: navigateToCartPage,
              ),
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Text(
                    cartItemCount.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF612C7D),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                ),
                child: TextField(
                  onChanged: searchProduct,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Container(
            //     padding: EdgeInsets.all(8.0),
            //     child: Row(
            //       children: List.generate(
            //         filteredImagePaths.length,
            //         (index) => Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: CircleAvatar(
            //             radius: 50,
            //             backgroundImage: AssetImage(filteredImagePaths[index]),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 10),
            filteredImagePaths.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Produit non trouvé",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: MesProduits.allProducts.length,
                    itemBuilder: (context, index) {
                      final allproducts = MesProduits.allProducts[index];
                      return GestureDetector(
                        onTap: () => //{
                            Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(
                              product: allproducts,
                            ),
                          ),
                        ),
                        //},
                        child: buildCard(
                            index,
                            Product(
                                imagePath: allproducts.imagePath,
                                name: allproducts.name,
                                description: allproducts.description,
                                price: allproducts.price)),
                      );
                    }),
          ],
        ),
      ),
    );
  }

  Widget buildCard(index, Product product) {
    return Card(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/pantalon.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${product.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () => addToCart(product),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ajouter auii',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Icon(Icons.shopping_cart, color: Colors.white),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    backgroundColor: Color(0xFF612C7D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment(1, -1),
            child: IconButton(
              icon: Icon(
                isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
                color: isFavoritedList[index] ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavoritedList[index] = !isFavoritedList[index];
                });

                // Vérifier si le produit est ajouté aux favoris
                if (isFavoritedList[index]) {
                  // Créer une instance de produit
                  Product favoriteProduct = Product(
                    imagePath: product.imagePath,
                    name: product.name,
                    description: 'ma description',
                    price: product.price,
                  );

                  // Ajouter le produit aux favoris dans Firestore
                  addFavoriteToFirestore(favoriteProduct);

                  // Afficher une alerte pour confirmer l'ajout aux favoris
                  showAddToFavoritesDialog(context, product.name);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour ajouter un produit aux favoris dans Firestore
  // Méthode pour ajouter un produit aux favoris dans Firestore
  void addFavoriteToFirestore(Product favoriteProduct) {
    CollectionReference favorites =
        FirebaseFirestore.instance.collection('favoris');

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Gérer le cas où l'utilisateur n'est pas connecté
      print("L'utilisateur n'est pas connecté.");
      return;
    }

    String userID = user.uid;

    // Ajouter le produit aux favoris dans Firestore avec l'ID de l'utilisateur
    favorites
        .add({
          ...favoriteProduct.toMap(), // Les données du produit
          'userID': userID, // Ajout de l'ID de l'utilisateur
        })
        .then((value) =>
            print("Produit ajouté aux favoris avec l'ID: ${value.id}"))
        .catchError(
            (error) => print("Erreur lors de l'ajout aux favoris: $error"));
  }

  // Afficher une alerte après l'ajout d'un produit aux favoris
  void showAddToFavoritesDialog(BuildContext context, String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Produit ajouté aux favoris'),
          content: Text('$productName a été ajouté à vos favoris.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
            ),
          ],
        );
      },
    );
  }
}

class Order {
  final String imageUrl;
  final String idClient;
  final String prenom;
  final String nom;
  final String email;
  final String nomProduit;
  final int nbrProduit;
  final double prix;
  final double totalAmount;
  final DateTime timestamp;

  Order({
    required this.imageUrl,
    required this.idClient,
    required this.prenom,
    required this.nom,
    required this.email,
    required this.nomProduit,
    required this.nbrProduit,
    required this.prix,
    required this.totalAmount,
    required this.timestamp,
  });

  // Convertir la commande en un map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'idClient': idClient,
      'prenom': prenom,
      'nom': nom,
      'email': email,
      'nomProduit': nomProduit,
      'nbrProduit': nbrProduit,
      'prix': prix,
      'totalAmount': totalAmount,
      'timestamp': timestamp,
    };
  }
}













// import 'package:firebase_auth/firebase_auth.dart';
// //import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:niefeko/Components/Category/MesProduits.dart';
// import 'package:niefeko/Pages/Category/detail.dart';
// import 'package:niefeko/Pages/Recherche/recherche.dart';
// import 'package:niefeko/Components/Category/product.dart';

// class MemeCategorie0 extends StatefulWidget {
//   @override
//   // ignore: library_private_types_in_public_api
//   _CategoryPageState createState() => _CategoryPageState();
// }

// class _CategoryPageState extends State<MemeCategorie0> {
//   List<bool> isFavoritedList = List.generate(20, (index) => false);
//   List<double> prices = [];
//   List<String> filteredImagePaths = [];
//   List<Product> filteredProducts = [];
//   String selectedCategory = 'chaussures';

//   get navigateToCartPage => null;

//   get cartItemCount => "";

//   get searchProduct => null; // Exemple de catégorie sélectionnée

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   filterProductsByCategory(
//   //       selectedCategory); // Filtrer les produits par catégorie au démarrage
//   // }

//   // void filterProductsByCategory(String category) {
//   //   setState(() {
//   //     filteredProducts = MesProduits.allProducts
//   //         .where((product) => product.category == category)
//   //         .toList();
//   //   });
//   // }

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
//                     // category: product.category,
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
