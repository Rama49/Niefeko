import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      color: Color(0xFF593070),
      height: 660,
      child:Column(children: [
        Image.asset(
                  "logoNiefeko.png",
                  width: 100,
                  height: 100,
                ),
        //  const Text("Bienvenu a Niefeko",
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                       )),
       Form(
        
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Entrer votre Nom',  fillColor: Color.fromARGB(255, 16, 224, 47),),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(labelText: 'Entrer votre Prenom',  fillColor: Color.fromARGB(255, 16, 224, 47),),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(labelText: 'Entrer votre email',  fillColor: Color.fromARGB(255, 16, 224, 47),),
          ),
          SizedBox(height: 20),
           TextFormField(
            decoration: InputDecoration(labelText: 'Entrer votre  mot de passe'),
          ),
           SizedBox(height: 20),
           TextFormField(
            decoration: InputDecoration(labelText: 'Confirmer votre  mot de passe'),
          ),
          BoutonR(titre: "S'inscrire", onPressed: () {
                  // Navigator.push(
                  //   context
                  //   // MaterialPageRoute(builder: (context) => carteReu()),
                  // );
                },)
        ]),
      ),],)
    );
  }
}

