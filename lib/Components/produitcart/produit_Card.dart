import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class product extends StatefulWidget {
  @override
  _productState createState() => _productState();
}

class _productState extends State<product> {
  List<dynamic> suppliers = [];

  @override
  void initState() {
    super.initState();
    fetchSuppliers();
  }

  Future<void> fetchSuppliers() async {
    const url = 'https://niefeko.com/wp-json/dokan/v1/stores'; // Remplacez par l'URL de votre API
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          suppliers = json.decode(response.body);
        });
      } else {
        throw 'Erreur de chargement des fournisseurs';
      }
    } catch (e) {
      print('Erreur lors de la récupération des fournisseurs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nos Boutiques",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          itemCount: suppliers.length,
          itemBuilder: (BuildContext context, int index) {
            final supplier = suppliers[index];
            final storeName = supplier['store_name'] ?? 'Nom inconnu';
            final imageUrl = supplier['gravatar'] ?? 'inconu';
            return Card(
              color: const Color.fromARGB(255, 215, 194, 233),
              child: InkWell(
                onTap: () {
                  //_launchURL(supplier['shop_url'] ?? '');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storeName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      // Autres détails du fournisseur...
                      if (imageUrl.isNotEmpty)
                        Image.network(
                          imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

}
