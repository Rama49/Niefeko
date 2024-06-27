import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'FournisseurProduct.dart';

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
    const url = 'https://niefeko.com/wp-json/dokan/v1/stores'; 
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
            final payment = supplier['payment'] ?? 'inconu';
            return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child:
            Card(
              color: const Color.fromARGB(255, 215, 194, 233),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FournisseurProduct(supplierId: supplier['id'], storeName: supplier['store_name'],),
                ),
              );
                },
                  
child: Padding(
              padding: EdgeInsets.all(16.0),
              //alignment: Alignment.center,
              child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                    child: Image.network(
                     imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),),
                     Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            storeName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          ),
                          SizedBox(height: 4),
                          Text(
                            payment,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.purple),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              //],
            ),

              ),
            ));
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

}