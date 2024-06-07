import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Resetpassword extends StatefulWidget {
  @override
  _ResetpasswordState createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String apiUrl = 'https://niefeko.com/wp-json/jwt-auth/v1/forget-password ';
      
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {'email': email},
        );

        if (response.statusCode == 200) {
          // Succès, affichez un message à l'utilisateur
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Un e-mail de réinitialisation de mot de passe a été envoyé. Veuillez vérifier votre boîte de réception.",
              ),
            ),
          );
        } else {
          // Erreur lors de l'envoi de la demande
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Erreur lors de la réinitialisation du mot de passe. Veuillez réessayer plus tard.",
              ),
            ),
          );
        }
      } catch (e) {
        // Erreur lors de l'envoi de la demande
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Erreur lors de la réinitialisation du mot de passe. Veuillez réessayer plus tard.",
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text(
          'Réinitialisation de mot de passe',
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
                ElevatedButton(
                  onPressed: _resetPassword,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
                    backgroundColor: const Color(0xFF612C7D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    'Réinitialiser le mot de passe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
