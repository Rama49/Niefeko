import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Resetpassword extends StatefulWidget {
  @override
  _ResetpasswordState createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false; // Nouvelle variable pour gérer l'état du chargement

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true; // Activer le chargement lors de la soumission du formulaire
    });

    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();

      try {
        const String apiUrl = 'https://niefeko.com/wp-json/jwt-auth/v1/forget-password';
        
        final Map<String, dynamic> data = {'username': email};
        final String jsonData = jsonEncode(data);

        print('Email à envoyer: $email');
        print('Corps de la requête: $jsonData');

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonData,
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Un e-mail de réinitialisation de mot de passe a été envoyé. Veuillez vérifier votre boîte de réception."),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erreur lors de la réinitialisation du mot de passe. Veuillez réessayer plus tard. Code: ${response.statusCode}, Message: ${response.body}"),
            ),
          );
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erreur lors de la réinitialisation du mot de passe. Veuillez réessayer plus tard."),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false; // Désactiver le chargement à la fin du traitement
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text(
          'Mot de passe oublié',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Adresse e-mail',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF593070)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une adresse e-mail valide';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _resetPassword,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 47,
                        vertical: 15,
                      ),
                      backgroundColor: const Color(0xFF612C7D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: const BorderSide(color: Color(0xFF612C7D)),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF612C7D),
                              ),
                            ),
                          )
                        : const Text(
                            "Réinitialiser votre mot de passe",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
