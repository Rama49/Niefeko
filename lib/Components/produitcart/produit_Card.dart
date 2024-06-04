// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
// ignore: unused_import
import 'package:niefeko/Components/Deals/deal.dart';
import 'package:niefeko/Pages/Boutique/boutique.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class product extends StatelessWidget {
  const product({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Nos Boutiques",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          color: const Color.fromARGB(255, 215, 194, 233),
          child: InkWell(
            onTap: () {
              
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logoAfricavivre.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Fournisseur1",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 105),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "membre depuis 1 ans",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          color: const Color.fromARGB(255, 215, 194, 233),
          child: InkWell(
             onTap: () {
              _launchURL();
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logoafriquevert.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Fournisseur2",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 105),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "membre depuis 6 mois",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          color: const Color.fromARGB(255, 215, 194, 233),
          child: InkWell(
            onTap: () {
              _launchURL();
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logoanka.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Fournisseur3",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 105),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "membre depuis 1 mois",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          color: const Color.fromARGB(255, 215, 194, 233),
          child: InkWell(
             onTap: () {
              _launchURL();
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logoApi.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Fournisseur4",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 105),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "membre depuis 2 ans",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          color: const Color.fromARGB(255, 215, 194, 233),
          child: InkWell(
             onTap: () {
              _launchURL();
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logoAramet.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Fournisseur5",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 105),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "membre depuis 3 mois",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          color: const Color.fromARGB(255, 215, 194, 233),
          child: InkWell(
             onTap: () {
              _launchURL();
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logoBakeli.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Fournisseur6",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 105),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "membre depuis 3 ans",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          color: const Color.fromARGB(255, 215, 194, 233),
          child: InkWell(
             onTap: () {
              _launchURL();
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logoCap.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Fournisseur7",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 105),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "membre depuis 3 ans",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          color: const Color.fromARGB(255, 215, 194, 233),
          child: InkWell(
            onTap: () {
              _launchURL();
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logoDjolo.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Fournisseur8",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 105),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "membre depuis 7 mois",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          color: const Color.fromARGB(255, 215, 194, 233),
          child: InkWell(
             onTap: () {
              _launchURL();
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logoPacao.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Fournisseur9",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 105),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "membre depuis 3 ans",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          color: const Color.fromARGB(255, 215, 194, 233),
          child: InkWell(
             onTap: () {
              _launchURL();
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logoafriquevert.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Fournisseur10",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 105),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "membre depuis 1 ans",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          color: const Color.fromARGB(255, 215, 194, 233),
          child: InkWell(
            onTap: () {
              _launchURL();
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logoApi.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Fournisseur11",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 105),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "membre depuis  9 mois",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
    ]);
  }
void _launchURL() async {
    const url = 'https://bitazimut.com/niefeko/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
