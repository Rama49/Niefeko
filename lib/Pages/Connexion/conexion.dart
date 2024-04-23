import 'package:flutter/material.dart';
import 'package:niefeko/Components/Carte/Recherche/recherche.dart';
import 'package:niefeko/Pages/Inscription/inscription.dart';
import 'package:niefeko/Reutilisable/buttonReu.dart';




class conexion extends StatefulWidget {
  const conexion({super.key});

  @override
  State<conexion> createState() => _conexionState();
}

class _conexionState extends State<conexion> {
    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  Container(
      color: Color(0xFF612C7D),
      child: Container(
          height: 660,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              Image.asset(
                "logoNiefeko.png",
                width: 80,
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Text("bienvenue a la page de connexion", style: TextStyle(
                                         fontSize: 20,
                                         color: Colors.white
                                       )),
              ),

            const Padding(padding: EdgeInsets.only(top: 10)),


              //  const Text("Bienvenu a Niefeko",
              //                       style: TextStyle(
              //                         fontSize: 20,
              //                       )),
              Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 40, right: 40),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white), // Couleur du texte
                      decoration: const InputDecoration(
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
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  // SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 40, right: 40),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white), // Couleur du texte
                      decoration: const InputDecoration(
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

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => inscription()),
                      );
                    },
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF612C7D),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5)
        ),
      ),
      child: const Text(
        "Mot de passe oublié",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 13,
          

          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    ),

                  const Padding(padding: EdgeInsets.only(top: 30)),
                  // SizedBox(height: 20),
                   BoutonR(
                    titre: "Se Connecter",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => search()),
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                ]),
              ),
            ],
          ),

          ),
    ),
    
);

  }
}