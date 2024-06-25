import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Order {
  final int orderId;
  final String orderKey;
  final String status;
  final double total;
  final String currency;
  final List<OrderItem> lineItems;

  Order({
    required this.orderId,
    required this.orderKey,
    required this.status,
    required this.total,
    required this.currency,
    required this.lineItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    // Parsing the 'line_items' field from JSON
    var itemsJson = json['line_items'] as List;
    List<OrderItem> itemsList =
        itemsJson.map((item) => OrderItem.fromJson(item)).toList();

    return Order(
      orderId: json['order_id'],
      orderKey: json['order_key'],
      status: json['status'],
      total: double.parse(json['total'].toString()),
      currency: json['currency'],
      lineItems: itemsList,
    );
  }
}

class OrderItem {
  final int productId;
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
    final url =
        Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/orders');

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
        final List<dynamic> responseData = json.decode(response.body);
        print('Response data: $responseData'); // Print the response data

        setState(() {
          orders = responseData.map((json) => Order.fromJson(json)).toList();
          isLoading = false;
        });
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
                        title: Text('Commande ${order.orderId}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total: ${order.total} ${order.currency}'),
                            Text('Statut: ${order.status}'),
                          ],
                        ),
                        onTap: () {
                          // Show order details
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Détails de la Commande'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: order.lineItems.map((item) {
                                    return ListTile(
                                      title: Text(item.productName),
                                      subtitle: Text(
                                        'Prix: ${item.price} ${order.currency}\nQuantité: ${item.quantity}',
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

