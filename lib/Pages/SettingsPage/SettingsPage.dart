import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:niefeko/Pages/Connexion/connexion.dart';
import 'package:niefeko/Pages/ModifierMDP/ModifierMDP.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? firstName = '';
  String? lastName = '';
  String? email = '';

  Future<void> _getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await http.get(
        Uri.parse('https://niefeko.com/wp-json/api/user'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        setState(() {
          firstName = userData['firstname'];
          lastName = userData['lastname'];
          email = userData['email'];
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print('Error fetching user data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load user data'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF612C7D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text(
          'Paramètres',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(
              Icons.person,
              size: 100.0,
              color: Color.fromARGB(255, 215, 194, 233),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Informations sur l'utilisateur (prénom, nom, email)
                Text(
                  'Prénom: $firstName',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Nom: $lastName',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Email: $email',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, right: 16, left: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: ListTile(
                title: const Text('Modifier le mot de passe', style: TextStyle(color: Color(0xFF612C7D))),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModifierMDP()),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, right: 16, left: 16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF612C7D),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.white),
              ),
              child: ListTile(
                title: const Text('Déconnexion', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  try {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.remove('token');

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const connexion()),
                    );
                  } catch (error) {
                    print('Error during logout: $error');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Erreur lors de la déconnexion'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
