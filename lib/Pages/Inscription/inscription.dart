import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:niefeko/Components/Carte/recherche/recherche.dart';
import 'package:niefeko/Pages/Connexion/conexion.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';

class inscription extends StatefulWidget {
  @override
  inscriptionState createState() {
    return inscriptionState();
  }
}

class inscriptionState extends State<inscription> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                width: 80,
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Text("bienvenue a la page d'inscription", style: TextStyle(
                                         fontSize: 20,
                                         color: Colors.white
                                       )),
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
                          color: Color(0xFF5B2B75)), // Couleur du texte
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
                              color:
                                  Colors.white), // Bordure lorsque sélectionné
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 40, right: 40),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white), // Couleur du texte
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
                              color:
                                  Colors.white), // Bordure lorsque sélectionné
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 40, right: 40),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white), // Couleur du texte
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
                              color:
                                  Colors.white), // Bordure lorsque sélectionné
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 40, right: 40),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white), // Couleur du texte
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
                              color:
                                  Colors.white), // Bordure lorsque sélectionné
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 40, right: 40, bottom: 30),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white), // Couleur du texte
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
                              color:
                                  Colors.white), // Bordure lorsque sélectionné
                        ),
                      ),
                    ),
                  ),
                  BoutonR(
                    titre: "S'inscrire",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => conexion()),
                      );
                    },
                  )
                ]),
              ),
            ],
          )),
    );
  }
}
