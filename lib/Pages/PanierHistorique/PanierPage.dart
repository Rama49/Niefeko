import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PanierPage extends StatefulWidget {
  const PanierPage({Key? key}) : super(key: key);

  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  late Future<List<Order>> _futureOrders;
  final String? token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL25pZWZla28uY29tIiwiaWF0IjoxNzE5MzM0OTM1LCJuYmYiOjE3MTkzMzQ5MzUsImV4cCI6MTcxOTkzOTczNSwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMzUifX19.VwpU5B6hNeeCMwhdMZTvu-c34CCo3XtVVdcnLHt8u7Q"; // Remplacez par le jeton d'authentification réel

  @override
  void initState() {
    super.initState();
    _futureOrders = fetchOrders();
  }

  Future<List<Order>> fetchOrders() async {
    try {
      String userId = getCurrentUserId();

      final response = await http.get(
        Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/orders?user_id=$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Statut de la réponse : ${response.statusCode}');
      print('Corps de la réponse : ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> ordersJson = json.decode(response.body);
        return ordersJson.map((json) => Order.fromJson(json)).toList();
      } else if (response.statusCode == 403) {
        throw Exception('Accès refusé. Vérifiez les permissions de votre jeton.');
      } else {
        throw Exception('Échec de chargement des commandes. Statut: ${response.statusCode}');
      }
    } catch (error) {
      print('Exception lors de la récupération des commandes : $error');
      throw Exception('Échec de chargement des commandes. Erreur: $error');
    }
  }

  String getCurrentUserId() {
    return "35"; // Utilisez une méthode appropriée pour obtenir l'ID de l'utilisateur connecté
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text('Mes Commandes', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Order>>(
        future: _futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucune commande trouvée.'));
          } else {
            List<Order> orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                Order order = orders[index];
                return Card(
                  child: ListTile(
                    title: Text('Commande ${order.id}'),
                    subtitle: Text('Total: ${order.total} FCFA\nStatut: ${order.status}'),
                    onTap: () {
                      showOrderDetails(context, order);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void showOrderDetails(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Détails de la commande ${order.id}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: order.products.map((product) {
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Quantité: ${product.quantity}\nPrix: ${product.price} FCFA'),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Order {
  final String id;
  final String total;
  final String status;
  final List<Product> products;

  Order({
    required this.id,
    required this.total,
    required this.status,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products'] as List;
    List<Product> productsList = productsJson.map((i) => Product.fromJson(i)).toList();

    return Order(
      id: json['id'].toString(),
      total: json['total'].toString(),
      status: json['status'],
      products: productsList,
    );
  }
}

class Product {
  final String id;
  final String name;
  final double price;
  final String imagePath;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'],
      price: double.parse(json['price'].toString()),
      imagePath: json['image'],
      quantity: int.parse(json['quantity'].toString()),
    );
  }
}
