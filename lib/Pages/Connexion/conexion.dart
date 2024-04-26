import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niefeko/Components/Carte/Recherche/recherche.dart';
import 'package:niefeko/Pages/pageAcceuil/PageAcceuil.dart';

class connexion extends StatefulWidget {
  const connexion({Key? key}) : super(key: key);

  @override
  State<connexion> createState() => _connexionState();
}

class _connexionState extends State<connexion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true; // Variable pour gérer la visibilité du mot de passe

  // Fonction pour se connecter avec Firebase
  Future<void> _signInWithEmailAndPassword() async {
    try {
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
        backgroundColor: Colors.green, // Couleur de fond pour une connexion réussie
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Rediriger l'utilisateur vers la page de recherche
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => search()),
      );
    } catch (e) {
      // Erreur de connexion, afficher le toast correspondant
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
                      padding:
                          const EdgeInsets.only(top: 15, left: 40, right: 40),
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
                      padding:
                          const EdgeInsets.only(top: 15, left: 40, right: 40),
                      child: TextFormField(
                        controller: _passwordController,
                        style: TextStyle(color: Colors.white),
                        obscureText: _isObscure, // Utilisation de la variable pour masquer ou montrer le mot de passe
                        decoration: InputDecoration(
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
                          // Ajout de l'icône œil pour montrer ou masquer le mot de passe
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure; // Inversion de l'état de visibilité du mot de passe
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
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Veuillez entrer votre mot de passe';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => search()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF612C7D),
                        //padding:
                            //EdgeInsets.symmetric(horizontal: -50, vertical: 20),
                           // EdgeInsets.only(left: 10, right: 10),
                        //EdgeInsets.all(0.50),
                        //EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Container(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        width: 140,
                        child:
                             Row(
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
                                  
                                )
                                ),
                               ]
                             )
                      ),
                    ),
                    SizedBox(
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
                        backgroundColor: Color.fromARGB(255, 247, 246, 248),
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
                    SizedBox(height: 20),
                    SizedBox(height: 10),
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
