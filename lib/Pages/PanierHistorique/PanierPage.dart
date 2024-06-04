import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: use_key_in_widget_constructors
class PanierPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  late Stream<QuerySnapshot> _ordersStream;
  late String _currentUserUid; // ID de l'utilisateur actuellement connecté

  @override
  void initState() {
    super.initState();
    // Récupérer l'ID de l'utilisateur actuellement connecté
    _currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    // Filtrer les commandes par ID d'utilisateur
    _ordersStream = FirebaseFirestore.instance
        .collection('Panier')
        .where('idClient', isEqualTo: _currentUserUid) // Filtrer par ID utilisateur
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void _deleteOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Panier')
          .doc(orderId)
          .delete();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Commande supprimée avec succès'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
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
          if (snapshot.hasError) {
            // ignore: avoid_print
            print("Error: ${snapshot.error}");
            return const Center(
              child: Text('Une erreur est survenue'),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Votre historique de panier est vide'),
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
                    icon: const Icon(Icons.delete, color: Colors.red,),
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
