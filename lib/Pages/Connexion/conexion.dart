import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niefeko/Components/Recherche/recherche.dart';

// ignore: camel_case_types
class connexion extends StatefulWidget {
  // ignore: use_super_parameters
  const connexion({Key? key}) : super(key: key);

  @override
  State<connexion> createState() => _connexionState();
}

// ignore: camel_case_types
class _connexionState extends State<connexion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true; // Variable pour gérer la visibilité du mot de passe

  // Fonction pour se connecter avec Firebase
  Future<void> _signInWithEmailAndPassword() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Connexion réussie, afficher le toast correspondant
      Fluttertoast.showToast(
        msg: "Connexion réussie avec succès",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor:
            Colors.white, // Couleur de fond pour une connexion réussie
        textColor: const Color.fromARGB(255, 68, 8, 219),
        fontSize: 16.0,
      );
      // Rediriger l'utilisateur vers la page de recherche
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const search()),
      );
    } catch (e) {
      // Erreur de connexion, afficher le toast correspondant
      // ignore: avoid_print
      print("Erreur de connexion: $e");
      Fluttertoast.showToast(
        msg: "Erreur de connexion: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF612C7D),
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Column(
            children: [
              Image.asset(
                "logoNiefeko.png",
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(28),
                child: Text(
                  "Entrez vos identifiants pour accéder à votre compte",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 40, right: 40),
                      child: TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFF593070),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 40, right: 40),
                      child: TextFormField(
                        controller: _passwordController,
                        style: const TextStyle(color: Colors.white),
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: const Color(0xFF593070),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          // Ajout de l'icône œil pour montrer ou masquer le mot de passe
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure =
                                    !_isObscure; // Inversion de l'état de visibilité du mot de passe
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre mot de passe';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const search()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF612C7D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "Mot de passe oublié ?",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    )),
                              ])),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Vérifiez la validation du formulaire avant de se connecter
                        if (_formKey.currentState!.validate()) {
                          _signInWithEmailAndPassword();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 247, 246, 248),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(
                          fontSize: 16.0,
                          backgroundColor: Colors.white,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
