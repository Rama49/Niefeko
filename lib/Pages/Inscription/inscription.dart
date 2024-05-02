// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niefeko/Pages/Connexion/conexion.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';

// ignore: camel_case_types
class inscription extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _inscriptionState createState() => _inscriptionState();
}

// ignore: camel_case_types
class _inscriptionState extends State<inscription> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((_) {
      // ignore: avoid_print
      print("Firebase initialisé avec succès !");
    }).catchError((error) {
      // ignore: avoid_print
      print("Erreur lors de l'initialisation de Firebase : $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xFF612C7D),
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                "logoNiefeko.png",
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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 40, right: 40),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _nomController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre nom';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Nom',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFF5B2B75),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 40, right: 40),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _prenomController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre prénom';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Prénom',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFF593070),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 40, right: 40),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFF593070),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 40, right: 40),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre mot de passe';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFF593070),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 40, right: 40),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _confirmPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Les mots de passe ne correspondent pas';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Confirmer mot de passe',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFF593070),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BoutonR(
                      titre: "S'inscrire",
                      onPressed: () async {
                        await registerUser();
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const connexion()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF612C7D),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text(
                        "Avez-vous déjà un compte? Se connecter",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
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
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.white,
          textColor: Colors.purple,
          fontSize: 16.0,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const connexion()),
        );

        _nomController.clear();
        _prenomController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
      } catch (e) {
        // ignore: avoid_print
        print('Erreur lors de l\'inscription : $e');
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
