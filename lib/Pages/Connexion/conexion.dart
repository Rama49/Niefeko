import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:niefeko/Components/Carte/Recherche/recherche.dart';
import 'package:niefeko/Pages/Inscription/inscription.dart';

class conexion extends StatefulWidget {
  const conexion({Key? key}) : super(key: key);

  @override
  State<conexion> createState() => _conexionState();
}

class _conexionState extends State<conexion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fonction pour se connecter avec Firebase
  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Connexion réussie, rediriger l'utilisateur vers la page de recherche par exemple
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => search()),
      );
    } catch (e) {
      // Erreur de connexion
      print("Erreur de connexion: $e");
      // Gérer l'erreur ici, comme afficher un message à l'utilisateur
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF612C7D),
        child: Container(
          height: 660,
          child: Column(
            children: [
              Image.asset(
                  "logoNiefeko.png",
                  width: 80,
                  height: 80,
                ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Text(
                  "Entrez vos identifiants pour accéder à votre compte",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 40, right: 40),
                      child: TextFormField(
                        controller: _emailController,
                        style: TextStyle(color: Colors.white),
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
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Veuillez entrer votre email';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 40, right: 40),
                      child: TextFormField(
                        controller: _passwordController,
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Mot de passe',
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
                        return 'Veuillez entrer votre mot de passe';
                      }
                      return null;
                    },
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Veuillez entrer votre mot de passe';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Vérifiez la validation du formulaire avant de se connecter
                        if (_formKey.currentState!.validate()) {
                          _signInWithEmailAndPassword();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF612C7D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => inscription()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF612C7D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "Créer un compte",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
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
