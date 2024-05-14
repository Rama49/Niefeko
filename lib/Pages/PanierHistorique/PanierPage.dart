import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PanierPage extends StatefulWidget {
  final String userId;

  const PanierPage({Key? key, required this.userId}) : super(key: key);

  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  late Stream<QuerySnapshot> _ordersStream;

  @override
  void initState() {
    super.initState();
    _ordersStream = FirebaseFirestore.instance
        .collection('Panier')
        .where('userId', isEqualTo: widget.userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void _validatePanier(List<Commande> panier) async {
    try {
      // Ajoutez la commande à la fois dans la collection "Panier" et "HISTORIQUE"
      final timestamp = Timestamp.now();
      final commandeData = panier.map((commande) => commande.toJson()).toList();

      await FirebaseFirestore.instance.collection('Panier').add({
        'userId': widget.userId,
        'commande': commandeData,
        'timestamp': timestamp,
      });

      await FirebaseFirestore.instance.collection('HISTORIQUE').add({
        'userId': widget.userId,
        'commande': commandeData,
        'timestamp': timestamp,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Commande validée avec succès'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la validation de la commande'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _deleteOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Panier')
          .doc(orderId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Commande supprimée avec succès'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la suppression de la commande'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text(
          'Historique des commandes',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Votre historique de panier est vide'),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Une erreur est survenue'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              Timestamp timestamp = data['timestamp'] as Timestamp;
              DateTime date = timestamp.toDate();
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  _deleteOrder(doc.id);
                },
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirmation"),
                        content: const Text(
                            "Êtes-vous sûr de vouloir supprimer cette commande ?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Supprimer"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Annuler"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: ListTile(
                  leading: Image.asset(data['imageUrl']),
                  title: Text(data['nomProduit']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantité: ${data['nbrProduit']}'),
                      Text('Prix: ${data['totalAmount']} \$'),
                      Text(
                        'Date et heure: ${DateFormat('dd/MM/yyyy HH:mm').format(date)}',
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteOrder(doc.id);
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class Commande {
  final String nomProduit;
  final int nbrProduit;
  final double totalAmount;
  final String imageUrl;

  Commande({
    required this.nomProduit,
    required this.nbrProduit,
    required this.totalAmount,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'nomProduit': nomProduit,
      'nbrProduit': nbrProduit,
      'totalAmount': totalAmount,
      'imageUrl': imageUrl,
    };
  }
}
