import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModifierMDP extends StatefulWidget {
  @override
  _ModifierMDPState createState() => _ModifierMDPState();
}

class _ModifierMDPState extends State<ModifierMDP> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _oldPassword;
  late String _newPassword;
  late String _confirmNewPassword;
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmNewPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF612C7D),
        title: const Text(
          'Modifier le mot de passe',
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
              children: [
                _buildTextField(
                  labelText: 'Adresse e-mail',
                  onChanged: (value) => _email = value,
                ),
                _buildPasswordTextField(
                  labelText: 'Ancien mot de passe',
                  onChanged: (value) => _oldPassword = value,
                  isVisible: _oldPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _oldPasswordVisible = !_oldPasswordVisible;
                    });
                  },
                ),
                _buildPasswordTextField(
                  labelText: 'Nouveau mot de passe',
                  onChanged: (value) => _newPassword = value,
                  isVisible: _newPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _newPasswordVisible = !_newPasswordVisible;
                    });
                  },
                ),
                _buildPasswordTextField(
                  labelText: 'Confirmer le nouveau mot de passe',
                  onChanged: (value) => _confirmNewPassword = value,
                  isVisible: _confirmNewPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _confirmNewPasswordVisible = !_confirmNewPasswordVisible;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_newPassword != _confirmNewPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Les mots de passe ne correspondent pas'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        _changePassword(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    backgroundColor: const Color(0xFF612C7D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    'Modifier',
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

  Widget _buildTextField({
    required String labelText,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer $labelText';
            }
            return null;
          },
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField({
    required String labelText,
    required ValueChanged<String> onChanged,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: IconButton(
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: onVisibilityToggle,
            ),
            border: const OutlineInputBorder(),
          ),
          obscureText: !isVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer $labelText';
            }
            return null;
          },
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _changePassword(BuildContext context) async {
    if (_email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer une adresse e-mail'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://niefeko.com/wp-json/custom-/v1/password/new'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_email': _email,
          'old_password': _oldPassword,
          'new_password': _newPassword,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mot de passe modifié avec succès'),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Erreur lors de la modification du mot de passe: ${response.body}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Erreur lors de la modification du mot de passe: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
