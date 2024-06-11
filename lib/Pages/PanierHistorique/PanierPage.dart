import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PanierPage extends StatefulWidget {
  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  List<dynamic> _orders = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://niefeko.com/wp-json/custom-routes/v1/customer/orders'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer VOTRE_JETON_ICI', // Remplacez par votre jeton
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> orders = jsonDecode(response.body);
        setState(() {
          _orders = orders;
          _isLoading = false;
        });
      } else if (response.statusCode == 403) {
        print('Accès interdit: ${response.statusCode}. Vérifiez vos permissions.');
        setState(() {
          _isLoading = false;
        });
      } else {
        print('Échec du chargement des commandes: ${response.statusCode}');
        throw Exception('Échec du chargement des commandes');
      }
    } catch (error) {
      print('Error fetching orders: $error');
      setState(() {
        _isLoading = false;
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator())
          : _orders.isEmpty
              ? Center(
                  child: Text('Aucune commande trouvée'))
              : ListView.builder(
                  itemCount: _orders.length,
                  itemBuilder: (context, index) {
                    var order = _orders[index];
                    return ListTile(
                      title: Text(order['nomProduit'] ?? 'Nom produit inconnu'),
                      subtitle: Text('Quantité: ${order['nbrProduit'] ?? 'Inconnue'}'),
                      trailing: Text('Prix: ${order['totalAmount'] ?? 'Inconnu'} FCFA'),
                    );
                  },
                ),
    );
  }
}
