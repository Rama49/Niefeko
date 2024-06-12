import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PanierPage extends StatefulWidget {
  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  List<Order> orders = []; // Liste des commandes de l'utilisateur
  bool isLoading = false; // Variable pour suivre l'état du chargement

  @override
  void initState() {
    super.initState();
    fetchOrders(); // Récupérer les commandes de l'utilisateur lors du chargement de la page
  }

  Future<void> fetchOrders() async {
    try {
      // Indiquer le début du chargement
      setState(() {
        isLoading = true;
      });

      // Récupérer les commandes de l'utilisateur via une API
      // Vous devrez remplacer 'user_email' par l'email de l'utilisateur connecté
      const user_email = "mloum137@gmail.com"; // Email de l'utilisateur connecté
      final response = await http.get(
        Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/orders?user_email=$user_email'),
      );

      if (response.statusCode == 200) {
        // Si la requête réussit, mettre à jour la liste des commandes
        List<dynamic> responseData = json.decode(response.body);
        setState(() {
          orders = responseData.map((data) => Order.fromJson(data)).toList();
        });
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (error) {
      print('Error fetching orders: $error');
      // Affichage d'un message d'erreur à l'utilisateur en cas d'échec de la récupération des commandes
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Impossible de charger les commandes. Veuillez réessayer plus tard.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      // Indiquer la fin du chargement, quel que soit le résultat
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Commandes'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(), // Afficher un indicateur de chargement
            )
          : orders.isEmpty
              ? Center(
                  child: Text('Aucune commande trouvée'),
                )
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return ListTile(
                      title: Text('Commande #${order.id}'),
                      subtitle: Text('Total: ${order.total} FCFA'),
                      // Vous pouvez ajouter plus de détails sur la commande ici
                    );
                  },
                ),
    );
  }
}

class Order {
  final int id;
  final double total;

  Order({
    required this.id,
    required this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      total: double.parse(json['total'].toString()),
    );
  }
}
