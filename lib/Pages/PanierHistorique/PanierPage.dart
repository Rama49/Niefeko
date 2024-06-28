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
    var itemsJson = json['line_items'] as List;
    List<OrderItem> itemsList =
        itemsJson.map((item) => OrderItem.fromJson(item)).toList();

    return Order(
      orderId: json['order_id'],
      orderKey: json['order_key'],
      status: json['status'],
      total: json['total'] != null
          ? double.tryParse(json['total'].toString()) ?? 0.0
          : 0.0,
      currency: json['currency'] ?? '',
      lineItems: itemsList,
    );
  }
}

class OrderItem {
  final int productId;
  final String productName;
  final double price;
  final int quantity;
  final String date;
  final String productImage;
  final String status;
  final String email;
  final String dateCreated;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.date,
    required this.productImage,
    required this.status,
    required this.email,
    required this.dateCreated,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'] ?? 0,
      productName: json['name'] ?? 'Non disponible',
      price: json['total'] != null
          ? double.tryParse(json['total'].toString()) ?? 0.0
          : 0.0,
      quantity: json['quantity'] != null
          ? int.tryParse(json['quantity'].toString()) ?? 0
          : 0,
      date: json['date_created'] ?? 'Non disponible',
      productImage:
          json['image'] != null ? json['image']['url'] : 'assets/casque.png',
      status: json['status'] ?? 'Non disponible',
      email: json['billing_address'] != null
          ? json['billing_address']['email'] ?? 'Non disponible'
          : 'Non disponible',
      dateCreated: json['date_created'] ?? 'Non disponible',
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
      print('Tokenedaaaa: $token');

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        print('Response data: $responseData');

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

  Future<void> fetchOrderDetails(int orderId) async {
    final url = Uri.parse(
        'https://niefeko.com/wp-json/custom-routes/v1/customer/order/$orderId');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Détails de la Commande ${responseData['order_id']}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Statut: ${responseData['status']}'),
                  Text('Email: ${responseData['billing_address']['email']}'),
                  Text('Date de création: ${responseData['date_created']}'),
                  Divider(),
                  Text('Articles:'),
                  ...(responseData['line_items'] as List).map((item) {
                    return ListTile(
                      leading: item['image'] != null
                          ? Image.network(item['image']['url'])
                          : null,
                      title: Text(item['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Prix: ${item['total']} ${responseData['currency']}'),
                          Text('Quantité: ${item['quantity']}'),
                          Text(
                              'Date: ${responseData['date_created']}'),
                          Text('Statut: ${responseData['status']}'),
                          Text(
                              'Email: ${responseData['billing_address']['email']}'),
                        ],
                      ),
                    );
                  }).toList(),
                ],
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
      } else {
        throw Exception('Failed to load order details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching order details: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch order details: $e'),
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

  Future<void> deleteOrder(int orderId) async {
    final url = Uri.parse(
        'https://niefeko.com/wp-json/custom-routes/v1/customer/orders/$orderId');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Delete response status: ${response.statusCode}');
      print('Delete response body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          orders.removeWhere((order) => order.orderId == orderId);
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Commande supprimée'),
              content:
                  Text('La commande $orderId a été supprimée avec succès.'),
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
      } else {
        throw Exception('Failed to delete order: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting order: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Erreur lors de la suppression de la commande: $e'),
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
                        leading: order.lineItems.isNotEmpty
                            ? Image.network(order.lineItems[0].productImage)
                            : null,
                        title: Text('Commande ${order.orderId}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total: ${order.total} ${order.currency}'),
                            Text('Statut: ${order.status}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            deleteOrder(order.orderId);
                          },
                        ),
                        onTap: () {
                          fetchOrderDetails(order.orderId);
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
