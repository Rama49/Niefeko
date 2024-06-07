import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModifierMDP extends StatefulWidget {
  @override
  _ModifierMDPState createState() => _ModifierMDPState();
}

class _ModifierMDPState extends State<ModifierMDP> {
  final _formKey = GlobalKey<FormState>();
  String _newPassword = '';
  String _confirmNewPassword = '';
  bool _newPasswordVisible = false;
  bool _confirmNewPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le mot de passe'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  obscureText: !_newPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Nouveau mot de passe',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _newPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _newPasswordVisible = !_newPasswordVisible;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _newPassword = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nouveau mot de passe';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: !_confirmNewPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Confirmer le nouveau mot de passe',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _confirmNewPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _confirmNewPasswordVisible =
                              !_confirmNewPasswordVisible;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _confirmNewPassword = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez confirmer votre nouveau mot de passe';
                    } else if (value != _newPassword) {
                      return 'Les mots de passe ne correspondent pas';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _changePassword();
                    }
                  },
                  child: Text('Modifier le mot de passe'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changePassword() async {
    try {
      // Remplacez 'username' par le nom d'utilisateur de l'utilisateur actuel
      String username = 'username';
      // Remplacez 'new password' par le nouveau mot de passe
      String newPassword = 'new password';

      final response = await http.post(
        Uri.parse('https://niefeko.com/wp-json/custom-/v1/password/new'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        // Mot de passe modifié avec succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mot de passe modifié avec succès'),
            duration: Duration(seconds: 2),
          ),
        );
        // Rediriger vers une autre page ou faire une autre action après la modification du mot de passe
      } else {
        // Erreur lors de la modification du mot de passe
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la modification du mot de passe'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // Gestion des erreurs
      print('Erreur lors de la modification du mot de passe: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la modification du mot de passe'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
