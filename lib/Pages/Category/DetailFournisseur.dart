import 'package:flutter/material.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Components/produitcart/FournisseurProduct.dart';
import 'package:niefeko/Pages/Recherche/recherche.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class DetailFournisseur extends StatefulWidget{
  final Product product;
  final String productId;
  final String storeName; 
  const DetailFournisseur({super.key, required this.product, required this.productId, required this.storeName});
   _DetailState createState() => _DetailState();

  }
  //int quantity = 1;
  int index = 0;
class _DetailState extends State<DetailFournisseur> {
  late Map<int, Product> products;
  List<dynamic> suppliers = [];
  List<bool> isFavoritedList = List.generate(20, (index) => false);
  List<double> prices = [];
  List<String> filteredImagePaths = [];
  List<String> imagePaths = [];
  int cartItemCount = 0;
  List<Product> cartItems = [];
  List<String> nomFournisseur = [];
  late Product product;

  @override
   void initState() {
  super.initState();
  fetchProductDetails(widget.productId);
  filteredImagePaths.addAll(imagePaths);
  product = Product(imagePath: '', name: '', description: '', price: 0);
}

  Future<void> fetchProductDetails(String productId) async {
    final apiUrl = Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/products');
    final payload = {"id": productId};

    try {
      final response = await http.post(
        apiUrl,
        body: json.encode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          product = Product.fromJson(data);
        });
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (error) {
      print('Error fetching product details: $error');
    }
  }

  void removeToCart(Product product){
    int existingIndex = 0;
    setState(() {

      cartItems[existingIndex].quantity--;
      cartItemCount--;
    });
  }

void addToCart(Product product) async {
      String imageUrl = product.imagePath;
      String productName = product.name;
      double price = product.price;
      //String description = product.description;
      
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
            description: product.description,
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

  @override
  Widget build(BuildContext context){
    return 
    buildCard(index ,Product(imagePath: widget.product.imagePath, name: widget.product.name, description: widget.product.description, price: widget.product.price));
  }

  Widget buildCard(index, Product product){
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
                      builder: (context) => FournisseurProduct(supplierId: suppliers.length, storeName: suppliers.toString()),
                    ),
                  );
                },
               
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(
                isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
                color: isFavoritedList[index] ? Colors.red : Colors.white,
              ),
                onPressed: () {
                    setState(() {
                  isFavoritedList[index] = !isFavoritedList[index];
                });
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
            height: MediaQuery.of(context).size.height * .20,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.network(product.imagePath,
            fit: BoxFit.contain,
            ),
            
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
                         Text(
                          '${product.price}F',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                               onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => search(),
                    ),
                  );
                },
                               child: Row(
                                children:  [
                                Text(//'fournisseur',
                                widget.storeName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF593070),
                                    ),
                                  ),
                                  Icon(Icons.storage_rounded),
                                  ]
                            ),
                       )],
                        ),
                      
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
                            itemBuilder: (context, Color) => 
                            Container(
                              margin: const EdgeInsets.only(right: 6),
                              width: 200,
                              //height: 10,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(40),
                              ),

                              child: ElevatedButton(onPressed: (){
                                          setState(() {
                                          addToCart(product);
                                                      },);},
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //ColorFiltered(colorFilter: ColorFilter.mode(Colors.black, BlendMode.colorBurn)),
                                     Image(
                                        height: 70,
                                        image: AssetImage(product.imagePath), //color: colors[Color]
                                        ),
                                    Text(
                                      product.name, 
                                      //textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ]
                                  ),)
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
        height: 140,
        // width: 200,
        // color: Color(0xFF593070),
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        width: double.infinity,
        //height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Color(0xFF593070),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 150,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  IconButton(onPressed: () {
                          if (cartItemCount > 1) {
                          setState(() {
                            //cartItemCount --;
                            removeToCart(product);
                          });
                         }
                        },
                         icon: Icon(Icons.remove_circle, color: Color(0xFF593070), size: 25,)
                         ),
                  const SizedBox(width: 4,),
                  Text(
                    "${cartItemCount}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 4,),
                  IconButton(onPressed: () {
                    setState(() {
                      //cartItemCount ++ ;
                      addToCart(product);
                    });
                  },
                  icon: Icon(Icons.add_circle, color: Color(0xFF593070), size: 25,)
                 )
                ],
              ),
            ),

           const SizedBox(width: 15),

            Expanded(
              child: ElevatedButton(
                onPressed: () => {},//navigateToCartPage(),
                child: Container(
                  width: 150,
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
// }

// class Order {
//   final String imageUrl;
//   final String idClient;
//   final String prenom;
//   final String nom;
//   final String email;
//   final String nomProduit;
//   final String nomFournisseur;
//   final int nbrProduit;
//   final String description;
//   //final String couleur;
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
//     required this.description,
//     required this.nomFournisseur,
//     required this.nbrProduit,
//     //required this.couleur,
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
//       'description': description,
//       'nomProduit': nomProduit,
//       'nomFournisseur': nomFournisseur,
//       'nbrProduit': nbrProduit,
//       //'couelur': couleur,
//       'prix': prix,
//       'totalAmount': totalAmount,
//       'timestamp': timestamp,
//     };
//   }
 }
  