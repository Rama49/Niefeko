// Toast/Toast.dart
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String message, BuildContext? context}) {
  if (context != null) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3, // Durée d'affichage de 3 secondes
      backgroundColor: Colors.white,
      textColor: Colors.purple,
      fontSize: 16.0,
    );
  } else {
    // Si le contexte est null, ignorez le toast ou gérez-le d'une autre manière
    print("Le contexte est null, impossible d'afficher le toast.");
  }
}
