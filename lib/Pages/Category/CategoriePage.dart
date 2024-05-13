import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:niefeko/Components/Category/MesProduits.dart';
import 'package:niefeko/Components/Category/detail.dart';
import 'package:niefeko/Components/Recherche/recherche.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
//import 'package:niefeko/Pages/Favoris/PageFavoris.dart';
import 'package:niefeko/Components/Category/product.dart';
//import 'package:niefeko/Components/Category/detail.dart';


class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();

}

class _CategoryPageState extends State<CategoryPage> {
    
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

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Inscription')
          .doc(userID)
          .get();

  void addToCart(Product product) {
    // Récupérer les informations nécessaires
    String imageUrl = product.imagePath;
    String productName = product.name;
        //filteredImagePaths[index].split('/').last.split('.').first;
    double price = product.price;
    DateTime timestamp = DateTime.now(); // Timestamp de la commande

    // TODO: Récupérer l'ID du client, le prénom et le nom du client
    String idClient = ""; // Remplir avec l'ID du client
    String prenom = ""; // Remplir avec le prénom du client
    String nom = ""; // Remplir avec le nom du client

    // Calculer le montant total
    double totalAmount = price * 1; // Pour l'exemple, mettons la quantité à 1

    // Créer une instance de la commande
    Order order = Order(
      imageUrl: imageUrl,
      idClient: idClient,
      prenom: prenom,
      nom: nom,
      nomProduit: productName,
      nbrProduit: 1, // Pour l'exemple, mettons la quantité à 1
      prix: price,
      totalAmount: totalAmount,
      timestamp: timestamp,
    );

    // Ajouter la commande à Firestore
    addOrderToFirestore(order);

    setState(() {
      cartItems.add(Product(
        imagePath: imageUrl,
        name: productName,
        description: 'description',
        price: price,
      ));
      cartItemCount++; // Incrémentez cartItemCount
    });
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
      cartItemCount--; // Décrémentez cartItemCount
    });
  }

  void navigateToCartPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPanier(cartItems: cartItems, removeFromCart: removeFromCart, idClient: userID, prenom: "prenom", nom: "nom", email: "email", validateCart: validateCart),
      );
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.all(8.0),
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
                       onTap: () =>//{

                          Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => Detail(product: allproducts),
                   ),
                   //child: buildCard(product: allProducts,),
                   ),
                   //},
                   child: buildCard(index, Product(imagePath: allproducts.imagePath, name: allproducts.name, description: allproducts.description, price: allproducts.price)),
                   );
                   }
                   )
     ]
    ),
    )
    );
  }  
  Widget buildCard(index, Product product){
  return Card(
child: 
 Stack(
      children: 
        [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                product.imagePath,
                width: 90,
                height: 90,
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
                    const SizedBox(height: 4),
                    Text(
                      '${product.price}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => addToCart(product),
                  child: Row(
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
            alignment: const Alignment(1, -1),
            child: IconButton(
              icon: Icon(
                isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
                color: isFavoritedList[index] ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavoritedList[index] = !isFavoritedList[index];
                });

                // Check if the product is added to favorites
                if (isFavoritedList[index]) {
                  // Create a product instance
                  Product favoriteProduct = Product(
                    imagePath: product.imagePath,
                    name: product.name,
                    description: 'ma description',
                    price: product.price,
                  );

                  // Add the product to favorites in Firestore
                  addFavoriteToFirestore(favoriteProduct);
                }
              },
            ),
          ),
        ],
      
    ),);

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