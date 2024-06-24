import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:niefeko/Components/Category/product.dart';

class PanierPage extends StatefulWidget {
  final String userId;

  const PanierPage({Key? key, required this.userId}) : super(key: key);

  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  late Future<List<Order>> _futureOrders;

  @override
  void initState() {
    super.initState();
    _futureOrders = fetchPanierPage();
  }

  Future<List<Order>> fetchPanierPage() async {
    final response = await http.get(
      Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/products/${widget.userId}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> productsJson = json.decode(response.body);
      return productsJson.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text(
          'Mes Commandes',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Order>>(
        future: _futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucune commande trouvée.'));
          } else {
            List<Order> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Order product = products[index];
                return Card(
                  child: ListTile(
                    title: Text('Commande ${product.id}'),
                    subtitle: Text('Total: ${product.total} FCFA\nStatut: ${product.status}'),
                    onTap: () {
                      // Afficher les détails de la commande
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
}

class Order {
  final String id;
  final String total;
  final String status;

  Order({
    required this.id,
    required this.total,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'].toString(),
      total: json['total'].toString(),
      status: json['status'],
    );
  }
}