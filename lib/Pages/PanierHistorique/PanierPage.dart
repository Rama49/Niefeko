import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PanierPage extends StatefulWidget {
  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  List<dynamic> _orders = []; // Liste pour stocker les commandes récupérées
  bool _isLoading =
      false; // Indicateur pour afficher une barre de progression lors du chargement

  @override
  void initState() {
    super.initState();
    _fetchOrders(); // Appel de la fonction pour récupérer les commandes au démarrage de la page
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading =
          true; // Mettre à jour l'indicateur de chargement pour afficher la barre de progression
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://niefeko.com/wp-json/custom-routes/v1/customer/orders'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _orders = jsonDecode(response
              .body); // Mettre à jour la liste des commandes avec les données récupérées
          _isLoading =
              false; // Mettre à jour l'indicateur de chargement une fois les données chargées
        });
      } else {
        print('Failed to load orders: ${response.statusCode}');
        throw Exception('Échec du chargement des commandes');
      }
    } catch (error) {
      print('Error fetching orders: $error');
      setState(() {
        _isLoading =
            false; // Mettre à jour l'indicateur de chargement en cas d'erreur
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text('Historique des commandes',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading // Vérifier si les données sont en cours de chargement
          ? Center(
              child:
                  CircularProgressIndicator()) // Afficher la barre de progression si les données sont en cours de chargement
          : _orders.isEmpty // Vérifier si aucune commande n'a été récupérée
              ? Center(
                  child: Text(
                      'Aucune commande trouvée')) // Afficher un message si aucune commande n'a été trouvée
              : ListView.builder(
                  // Afficher la liste des commandes
                  itemCount: _orders.length,
                  itemBuilder: (context, index) {
                    var order = _orders[index];
                    return ListTile(
                      title: Text(order['nomProduit']),
                      subtitle: Text('Quantité: ${order['nbrProduit']}'),
                      trailing: Text('Prix: ${order['totalAmount']} FCFA'),
                    );
                  },
                ),
    );
  }
}
