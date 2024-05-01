import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Ajout de l'import pour DateFormat

class PanierPage extends StatefulWidget {
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
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void _deleteOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Panier')
          .doc(orderId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Commande supprimée avec succès'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
        title: Text('Historique des commandes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Une erreur est survenue'),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Aucune commande trouvée'),
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
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  _deleteOrder(doc.id);
                },
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirmation"),
                        content: Text(
                            "Êtes-vous sûr de vouloir supprimer cette commande ?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text("Supprimer"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text("Annuler"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: ListTile(
                  leading: Image.network(
                      data['imageUrl']), // Affichage de l'image du produit
                  title: Text(data['nomProduit']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantité: ${data['nbrProduit']}'),
                      Text('Prix: ${data['totalAmount']} \$'), // Affichage du prix
                      // Affichage de la date et de l'heure de la commande
                      Text(
                        'Date et heure: ${DateFormat('dd/MM/yyyy HH:mm').format(date)}',
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
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
