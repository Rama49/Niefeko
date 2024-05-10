// Pages/Inscription/inscription.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niefeko/Pages/Connexion/connexion.dart';
// ignore: unused_import
import 'package:niefeko/Reutilisable/buttonreu.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  InscriptionState createState() => InscriptionState();
}

class InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((_) {
      
      
      print("Firebase initialisé avec succès !");
    }).catchError((error) {
     
      print("Erreur lors de l'initialisation de Firebase : $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF593070),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  "assets/logoNiefeko.png",
                  width: 80,
                  height: 80,
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: const Text(
                    "Inscrivez-vous pour vivre une expérience unique.",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildInputField(
                        label: 'Nom',
                        controller: _nomController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre nom';
                          }
                          return null;
                        },
                      ),
                      _buildInputField(
                        label: 'Prénom',
                        controller: _prenomController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre prénom';
                          }
                          return null;
                        },
                      ),
                      _buildInputField(
                        label: 'Email',
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre email';
                          }
                          return null;
                        },
                      ),
                      _buildPasswordField(
                        label: 'Mot de passe',
                        controller: _passwordController,
                        obscureText: _passwordObscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre mot de passe';
                          }
                          return null;
                        },
                        onPressed: () {
                          setState(() {
                            _passwordObscureText = !_passwordObscureText;
                          });
                        },
                      ),
                      _buildPasswordField(
                        label: 'Confirmer mot de passe',
                        controller: _confirmPasswordController,
                        obscureText: _confirmPasswordObscureText,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Les mots de passe ne correspondent pas';
                          }
                          return null;
                        },
                        onPressed: () {
                          setState(() {
                            _confirmPasswordObscureText =
                                !_confirmPasswordObscureText;
                          });
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: ElevatedButton(
                          onPressed: () async {
                            await registerUser();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                              side: const BorderSide(
                                color: Colors.white), // Bordure blanche
                            ),
                            minimumSize: const Size(150, 0), // Définir la largeur fixe
                          ),
                          child: const Text(
                            "S'inscrire",
                            style: TextStyle(fontSize: 16, color: Color(0xFF593070)),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Connexion(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF612C7D),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                              side: const BorderSide(
                                  color: Colors.white), // Bordure blanche
                            ),
                            minimumSize: const Size(150, 0), // Définir la largeur fixe
                          ),
                          child: const Text(
                            "Se connecter",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: const Color(0xFF5B2B75),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required String? Function(String?)? validator,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: const Color(0xFF5B2B75),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        String userID = userCredential.user!.uid;

        await FirebaseFirestore.instance
            .collection('Inscription')
            .doc(userID)
            .set({
          'nom': _nomController.text,
          'prenom': _prenomController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'confirmPassword': _confirmPasswordController.text,
        });

        Fluttertoast.showToast(
          msg: "Inscription réussie avec succès",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.white,
          textColor: Colors.purple,
          fontSize: 16.0,
        );

        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const Connexion()),
        );

        _nomController.clear();
        _prenomController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
      } catch (e) {
        // ignore: avoid_print
        print('Erreur lors de l\'Inscription : $e');
      }
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
