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
  final String productImage;
  final String dateCreated; // Ajout de la date de création

  OrderItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.productImage,
    required this.dateCreated,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'],
      productName: json['name'],
      price: double.parse(json['price'].toString()),
      quantity: int.parse(json['quantity'].toString()),
      productImage: json['imagePath'],
      dateCreated: json[
          'date_created'], // Assurez-vous que 'date_created' correspond à la clé JSON
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
      print('Token: $token');

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

        print('Response Data: $responseData'); // Ajout pour débogage

        // Vérifiez si l'email existe dans les données renvoyées
        String Email = responseData['billing_address'] != null
            ? responseData['billing_address']['email'] ?? 'Non disponible'
            : 'Non disponible';

        // Vérifiez si la date existe dans les données renvoyées
        String Date = responseData['billing_address'] != null
            ? responseData['billing_address']['date_modified'] ??
                'Non disponible'
            : 'Non disponible';

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
                  Text('Email: $Email'),
                  Text('Date: $Date'),
                  Text(
                      'Total: ${responseData['total']} ${responseData['currency']}'),
                  Divider(),
                  Text('Articles:'),
                  ...(responseData['line_items'] as List).map((item) {
                    return ListTile(
                      leading: Image.network(item['productImage']),
                      title: Text(item['productName']),
                      subtitle: Text(
                          'Prix: ${item['price']} ${responseData['currency']}\nQuantité: ${item['quantity']}\nDate: ${item['date_created']}'),
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
  final url = Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/orders');

  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'orderId': orderId}),
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
            content: Text('La commande $orderId a été supprimée avec succès.'),
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
