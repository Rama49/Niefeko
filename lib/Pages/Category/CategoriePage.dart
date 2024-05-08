// Pages/Category/CategoriePage.dart
// ignore_for_file: file_names, library_private_types_in_public_api, unused_local_variable, use_build_context_synchronously// ignore_for_file: file_names, library_private_types_in_public_api, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
// ignore: unused_import
import 'package:niefeko/Pages/Favoris/PageFavoris.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:niefeko/Components/Recherche/recherche.dart';
// ignore: duplicate_import
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
// import 'package:niefeko/Pages/PanierHistorique/PanierPage.dart';
// import 'package:niefeko/Pages/SettingsPage/SettingsPage.dart';

class Product {
  final String imagePath;
  final String name;
  final double price;
  int quantity; // Champ pour stocker la quantité du produit

  // Product({required this.imagePath, required this.name, required this.price});

  // Convertir le produit en un map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'name': name,
      'price': price,
    };
  }

  Product({
    required this.imagePath,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}

// ignore: use_key_in_widget_constructors
class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<bool> isFavoritedList = List.generate(20, (index) => false);
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
  List<double> prices = List.generate(20, (index) => 1000.0);
  List<String> filteredImagePaths = [];
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
    });
  }

  void addToCart(int index) async {
    String imageUrl = imagePaths[index];
    String productName = filteredImagePaths[index].split('/').last.split('.').first;
    double price = prices[index];
    DateTime timestamp = DateTime.now(); // Timestamp de la commande

    String idClient = ""; // Remplir avec l'ID du client
    String prenom = ""; // Remplir avec le prénom du client
    String nom = ""; // Remplir avec le nom du client

    // Calculer le montant total
    double totalAmount = price * 1; // Pour l'exemple, mettons la quantité à 1

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
          price: price,
          quantity: 1, // Initialiser la quantité à 1
        ));
        cartItemCount++; // Augmenter le nombre total d'articles dans le panier
      });
    }
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
      cartItemCount--;
    });
  }

  void navigateToCartPage() async {
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
        .catchError(
            // ignore: avoid_print
            (error) => print("Erreur lors de l'ajout de la commande: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart,
                    color: Colors.white, size: 40),
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
                    style: const TextStyle(color: Colors.white, fontSize: 12),
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
              color: const Color(0xFF612C7D),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                ),
                child: TextField(
                  onChanged: searchProduct,
                  decoration: const InputDecoration(
                    hintText: 'Recherche...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: List.generate(
                    filteredImagePaths.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(filteredImagePaths[index]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            filteredImagePaths.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
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
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: filteredImagePaths.length,
                    itemBuilder: (context, index) {
                      return buildCard(index);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(int index) {
    String imageName =
        filteredImagePaths[index].split('/').last.split('.').first;
    double price = prices[index];
    return Card(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                filteredImagePaths[index],
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      imageName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$$price',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () => addToCart(index),
                  // ignore: sort_child_properties_last
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ajouter au',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Icon(Icons.shopping_cart, color: Colors.white),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20),
                    // ignore: deprecated_member_use
                    backgroundColor: const Color(0xFF612C7D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: const Alignment(1, -1),
            child: IconButton(
              icon: Icon(
                isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
                color: isFavoritedList[index] ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => pageFavoris()),
                // );

                setState(() {
                  isFavoritedList[index] = !isFavoritedList[index];
                });

                // Vérifiez si le produit est ajouté aux favoris
                if (isFavoritedList[index]) {
                  // Créez une instance de produit
                  Product favoriteProduct = Product(
                    imagePath: imagePaths[index],
                    name: imageName,
                    price: price,
                  );

                  // Ajouter le produit aux favoris dans Firestore
                  addFavoriteToFirestore(favoriteProduct);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour ajouter un produit aux favoris dans Firestore
  void addFavoriteToFirestore(Product favoriteProduct) {
    // Référence à la collection "favorites" dans Firestore
    CollectionReference favorites =
        FirebaseFirestore.instance.collection('favoris');

    // Ajouter le produit aux favoris dans Firestore
    favorites.add(favoriteProduct.toMap()).then((value) =>
        // ignore: avoid_print
        print("Produit ajouté aux favoris avec l'ID: ${value.id}")).catchError(
        // ignore: avoid_print
        (error) => print("Erreur lors de l'ajout aux favoris: $error"));
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
