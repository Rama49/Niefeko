import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModifierMDP extends StatefulWidget {
  @override
  _ModifierMDPState createState() => _ModifierMDPState();
}

class _ModifierMDPState extends State<ModifierMDP> {
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  late String _newPassword;
  late String _confirmNewPassword;
  String?
      _oldPassword; // Ajout de la variable pour stocker l'ancien mot de passe

  bool _passwordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmNewPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Chargez le mot de passe actuel lors de l'initialisation de l'état
    _loadCurrentPassword();
  }

  Future<void> _loadCurrentPassword() async {
    try {
      // Récupérer l'utilisateur actuel
      User? user = FirebaseAuth.instance.currentUser;
      // Vérifier si l'utilisateur est connecté
      if (user != null) {
        // Récupérer les données de l'utilisateur depuis Firestore
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('Inscription')
            .doc(user.uid)
            .get();
        if (userData.exists) {
          String? currentPassword = userData['password'];
          setState(() {
            _password = currentPassword ?? '';
            _oldPassword = currentPassword; // Stockez l'ancien mot de passe
          });
        }
      }
    } catch (error) {
      print('Erreur lors du chargement du mot de passe actuel: $error');
    }
  }

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
                _buildPasswordTextField(
                  labelText: 'Mot de passe actuel',
                  initialValue: _password,
                  onChanged: (value) => _password = value,
                  isVisible: _passwordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                _buildPasswordTextField(
                  labelText: 'Nouveau mot de passe',
                  initialValue: '',
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
                  initialValue: '',
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
                      _changePassword(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    primary: const Color(0xFF612C7D),
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

  Widget _buildPasswordTextField({
    required String labelText,
    required String initialValue,
    required ValueChanged<String> onChanged,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: IconButton(
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: onVisibilityToggle,
            ),
            border: OutlineInputBorder(),
          ),
          initialValue: initialValue,
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
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: _password);
        await user.reauthenticateWithCredential(credential);

        await FirebaseFirestore.instance
            .collection('Inscription')
            .doc(user.uid)
            .update({
          'oldMotDePasse':
              _oldPassword, // Utilisez l'ancien mot de passe stocké
          'newMotDePasse': _newPassword,
          'motDePasse':
              _newPassword, // Mettez à jour le mot de passe avec le nouveau mot de passe
        });

        await user.updatePassword(_newPassword);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mot de passe modifié avec succès'),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.pop(context);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Erreur lors de la modification du mot de passe: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
