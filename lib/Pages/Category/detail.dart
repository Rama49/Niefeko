import 'package:flutter/material.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';
import 'package:niefeko/Pages/CartPanier/CartPanier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Detail extends StatefulWidget{
  final Product product;
  const Detail({super.key, required this.product});
   _DetailState createState() => _DetailState();

  }
  int quantity = 1;
  int index = 0;
class _DetailState extends State<Detail> {
List<bool> isFavoritedList = List.generate(20, (index) => false);
  List<double> prices = [];
  List<String> filteredImagePaths = [];
  List<String> imagePaths = [];
  int cartItemCount = 0;
  List<Product> cartItems = [];
  @override
  void initState() {
    super.initState();
    filteredImagePaths.addAll(imagePaths);
  }
void addToCart(Product product) async {
      String imageUrl = product.imagePath;
      String productName = product.name;
      double price = product.price;
      // DateTime timestamp = DateTime.now(); // Timestamp de la commande

      // String idClient = ""; // Remplir avec l'ID du client
      // String prenom = ""; // Remplir avec le prénom du client
      // String nom = ""; // Remplir avec le nom du client

      // Calculer le montant total
      //double totalAmount = price * 1; // Pour l'exemple, mettons la quantité à 1

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
          .then((value) => print("Commande ajoutée avec l'ID: ${value.id}"))
          .catchError(
  
              (error) => print("Erreur lors de l'ajout de la commande: $error"));
    }


  @override
  Widget build(BuildContext context){
    return 
    buildCard(index ,Product(imagePath: widget.product.imagePath, name: widget.product.name, description: widget.product.description, price: widget.product.price));
  }


 // @override
  Widget buildCard(index, Product product){
   // List<bool> isFavoritedList = List.generate(20, (index) => false);
   return Scaffold(
    backgroundColor: Color(0xFF593070),
    body: Column(
      children: [
        SizedBox(height: 36),
       Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(),
                    ),
                  );
                },
                style: IconButton.styleFrom(
                    //backgroundColor: Colors.white,
                    fixedSize: const Size(55, 55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
             //IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined,color: Colors.white,)),
              IconButton(
                icon: Icon(
                isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
                color: isFavoritedList[index] ? Colors.red : Colors.white,
              ),
                onPressed: () {
                    setState(() {
                  isFavoritedList[index] = !isFavoritedList[index];
                });

                // Vérifiez si le produit est ajouté aux favoris
                if (isFavoritedList[index]) {
                  // Créez une instance de produit
                  Product favoriteProduct = Product(
                    imagePath: product.imagePath,//'assets/gourde.png',
                    name: product.name,//imageName,//'Gourde',
                    description: product.description,
                    price: product.price, //price,
                  );

                  // Ajouter le produit aux favoris dans Firestore
                  addFavoriteToFirestore(favoriteProduct);
                }
                },
                style: IconButton.styleFrom(
                    //backgroundColor: Colors.white,
                    fixedSize: const Size(55, 55),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
          )
          ],
      ),
          Container(
            height: MediaQuery.of(context).size.height * .25,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.asset(product.imagePath),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 15, left: 40, right: 40)),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF593070),
                          ),
                        ),
                       // Row(
                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //children: [
                            // Text(
                            //   'Dans notre nouvelle collection',
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w600,
                            //     color: Color(0xFF593070),
                            //   ),
                            // ),
                          //],
                        //),
                        Text(
                          '${product.price}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF593070),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(right: 6),
                              width: 200,
                              //height: 10,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(40),
                              ),

                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                        height: 70,
                                        image: AssetImage('sac.jpg')),
                                    Text(
                                      "Sac à main",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      
bottomNavigationBar: Container(
        height: 100,
        color: Color(0xFF593070),
        //padding: EdgeInsets.symmetric(horizontal: 20),
        // alignment: Alignment.center,
        // width: double.infinity,
        // height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(color: Color(0xFF593070),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(10),
        //   topRight: Radius.circular(10)
        // )
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {
                    product.quantity =quantity;
                          if (product.quantity > 1) {
                         product.quantity -= 1;
                          setState(() {});
                         }
                        },
                         icon: Icon(Icons.remove)
                         ),
                  const SizedBox(width: 4,),
                  Text(
                    "${product.quantity}",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 4,),
                  IconButton(onPressed: () {
                    product.quantity =quantity;
                     product.quantity += 1;
                    setState(() {});
                  },
                  icon: Icon(Icons.add)
                 )
                ],
              ),
            ),

           const SizedBox(width: 5),

            Expanded(
              child: ElevatedButton(
                onPressed: () => addToCart(product),
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    '+ Ajouter au panier',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF593070),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }


  // Méthode pour ajouter un produit aux favoris dans Firestore
  void addFavoriteToFirestore(Product favoriteProduct) {
    // Référence à la collection "favorites" dans Firestore
    CollectionReference favorites =
        FirebaseFirestore.instance.collection('favoris');

    // Ajouter le produit aux favoris dans Firestore
    favorites
        .add(favoriteProduct.toMap())
        .then((value) =>
            print("Produit ajouté aux favoris avec l'ID: ${value.id}"))
        .catchError(
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
  
