import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PanierPage extends StatefulWidget {
  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  List<dynamic> _userOrders =
      []; // Liste pour stocker les commandes de l'utilisateur
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserOrders(); // Appeler la méthode pour récupérer les commandes de l'utilisateur
  }

  Future<void> _fetchUserOrders() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://niefeko.com/wp-json/custom-routes/v1/customer/orders'),
        // Ajoutez ici les en-têtes ou les paramètres nécessaires pour authentifier l'utilisateur, si nécessaire
      );

      if (response.statusCode == 200) {
        setState(() {
          _userOrders = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        print('Échec du chargement des commandes: ${response.statusCode}');
        throw Exception('Échec du chargement des commandes de l\'utilisateur');
      }
    } catch (error) {
      print('Error fetching user orders: $error');
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
        title: Text('Panier', style: TextStyle(color: Colors.white),),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _userOrders.isEmpty
              ? Center(
                  child: Text('Aucune commande trouvée pour cet utilisateur'),
                )
              : ListView.builder(
                  itemCount: _userOrders.length,
                  itemBuilder: (context, index) {
                    var order = _userOrders[index];
                    return ListTile(
                      title: Text('Commande #${order['id']}'),
                      // Ajoutez ici d'autres détails de la commande que vous souhaitez afficher
                    );
                  },
                ),
    );
  }
}
