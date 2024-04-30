import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

class PanierPage extends StatefulWidget {
  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  late User? _user;
  List<Order> _orders = []; // Liste des commandes

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _fetchOrderHistory(); // Récupérer l'historique des commandes
    }
  }

  // Fonction pour récupérer l'historique des commandes depuis Firestore
  Future<void> _fetchOrderHistory() async {
    try {
      String userID = _user!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('HistoriqueCommandes')
          .where('userId', isEqualTo: userID)
          .get();
      setState(() {
        _orders = querySnapshot.docs
            .map((doc) => Order.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (error) {
      print(
          'Erreur lors de la récupération de l\'historique des commandes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique des commandes'), // Titre de la page
      ),
      body: _orders.isEmpty
          ? Center(
              child: Text(
                  'Votre historique de panier est vide.'), // Message si l'historique est vide
            )
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return Card(
                  child: ListTile(
                    title: Text('Commande ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                        SizedBox(height: 8),
                        Text('Produits commandés:'),
                        Column(
                          children: order.products.map((product) {
                            return ListTile(
                              title: Text(product.name), // Nom du produit
                              subtitle: Text(
                                  '\$${product.price.toStringAsFixed(2)}'), // Prix du produit
                              leading: Image.asset(
                                  product.imagePath), // Image du produit
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Naviguer vers la page de détails de la commande
                    },
                  ),
                );
              },
            ),
    );
  }
}

// Classe pour représenter une commande
class Order {
  final String orderId;
  final String userId;
  final double totalAmount;
  final List<Product> products; // Liste des produits commandés

  Order({
    required this.orderId,
    required this.userId,
    required this.totalAmount,
    required this.products,
  });

  // Constructeur de l'objet Order à partir des données Firestore
  factory Order.fromMap(Map<String, dynamic> data) {
    // Convertir les données Firestore en instance d'Order
    List<Product> products = [];
    if (data['products'] != null) {
      products = (data['products'] as List<dynamic>).map((productData) {
        return Product(
          imagePath: productData['imagePath'],
          name: productData['name'],
          price: productData['price'],
        );
      }).toList();
    }

    return Order(
      orderId: data['orderId'] ?? '',
      userId: data['userId'] ?? '',
      totalAmount: data['totalAmount'] ?? 0.0,
      products: products,
    );
  }
}

// Classe pour représenter un produit
class Product {
  final String imagePath;
  final String name;
  final double price;

  Product({
    required this.imagePath,
    required this.name,
    required this.price,
  });
}
