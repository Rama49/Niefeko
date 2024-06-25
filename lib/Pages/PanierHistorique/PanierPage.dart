import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Order {
  final String id;
  final String total;
  final String status;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.total,
    required this.status,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List;
    List<OrderItem> itemsList =
        itemsJson.map((item) => OrderItem.fromJson(item)).toList();

    return Order(
      id: json['id'],
      total: json['total'].toString(),
      status: json['status'],
      items: itemsList,
    );
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final double price;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'],
      productName: json['name'],
      price: double.parse(json['price'].toString()),
      quantity: int.parse(json['quantity'].toString()),
    );
  }
}

class PanierPage extends StatefulWidget {
  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  List<Order> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

Future<void> fetchOrders() async {
  final url = Uri.parse(
      'https://niefeko.com/wp-json/custom-routes/v1/customer/orders');

  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    print('Token: $token'); // Print the token for debugging

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    print('Response status: ${response.statusCode}'); // Print status code
    print('Response body: ${response.body}'); // Print raw response body

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('Response data: $responseData'); // Print the response data

      if (responseData is List) {
        setState(() {
          orders = responseData.map((json) => Order.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Invalid data format: Expected a list');
      }
    } else {
      throw Exception('Failed to load orders: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching orders: $e');
    setState(() {
      isLoading = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch orders: $e'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF593070),
        title: const Text(
          'Mes Commandes',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? Center(child: Text('Aucune commande trouvée.'))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Card(
                      child: ListTile(
                        title: Text('Commande ${order.id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total: ${order.total} FCFA'),
                            Text('Statut: ${order.status}'),
                          ],
                        ),
                        onTap: () {
                          // Afficher les détails de la commande
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Détails de la Commande'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: order.items.map((item) {
                                    return ListTile(
                                      title: Text(item.productName),
                                      subtitle: Text(
                                        'Prix: ${item.price} FCFA\nQuantité: ${item.quantity}',
                                      ),
                                    );
                                  }).toList(),
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
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
