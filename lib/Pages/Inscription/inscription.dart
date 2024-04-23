import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:niefeko/Components/Carte/recherche/recherche.dart';
import 'package:niefeko/Pages/Connexion/conexion.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';

class inscription extends StatefulWidget {
  @override
  _inscriptionState createState() => _inscriptionState();
}

class _inscriptionState extends State<inscription> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialise Firebase ici
    Firebase.initializeApp().then((_) {
      print("Firebase initialisé avec succès !");
    }).catchError((error) {
      print("Erreur lors de l'initialisation de Firebase : $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFF612C7D),
        child: Container(
            height: 660,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "logoNiefeko.png",
                  width: 50,
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                      "Rejoignez notre communauté ! Inscrivez-vous pour vivre une expérience unique.",
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                //  const Text("Bienvenu a Niefeko",
                //                       style: TextStyle(
                //                         fontSize: 20,
                //                       )),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 25, left: 40, right: 40),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.white), // Couleur du texte
                        decoration: InputDecoration(
                          labelText: 'Nom',
                          labelStyle: TextStyle(
                              color: Colors.white), // Couleur du placeholder
                          filled: true,
                          fillColor: Color(0xFF5B2B75),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Bordure lorsque non sélectionné
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Bordure lorsque sélectionné
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 40, right: 40),
                      child: TextFormField(
                        style:
                            TextStyle(color: Colors.white), // Couleur du texte
                        decoration: InputDecoration(
                          labelText: 'Prenom',
                          labelStyle: TextStyle(
                              color: Colors.white), // Couleur du placeholder
                          filled: true,
                          fillColor: Color(0xFF593070),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Bordure lorsque non sélectionné
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Bordure lorsque sélectionné
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 40, right: 40),
                      child: TextFormField(
                        style:
                            TextStyle(color: Colors.white), // Couleur du texte
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Colors.white), // Couleur du placeholder
                          filled: true,
                          fillColor: Color(0xFF593070),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Bordure lorsque non sélectionné
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Bordure lorsque sélectionné
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 40, right: 40),
                      child: TextFormField(
                        style:
                            TextStyle(color: Colors.white), // Couleur du texte
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(
                              color: Colors.white), // Couleur du placeholder
                          filled: true,
                          fillColor: Color(0xFF593070),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Bordure lorsque non sélectionné
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Bordure lorsque sélectionné
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 40, right: 40, bottom: 0),
                      child: TextFormField(
                        style:
                            TextStyle(color: Colors.white), // Couleur du texte
                        decoration: InputDecoration(
                          labelText: 'Confirmer mot de passe',
                          labelStyle: TextStyle(
                              color: Colors.white), // Couleur du placeholder
                          filled: true,
                          fillColor: Color(0xFF593070),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Bordure lorsque non sélectionné
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // Bordure lorsque sélectionné
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                                        BoutonR(
                      titre: "S'inscrire",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => conexion()),
                        );
                      },
                    ),
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
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5)
        ),
      ),
      child: Text(
        "Avez vous deja un compte? Se connecter",
        style: TextStyle(
          fontSize: 
              14,
          color: Colors.white
        ),
      ),
    ),

                  ]),
                ),
              ],
            )),
      ),
    );
  }
}
