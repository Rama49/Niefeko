// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String message}){
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 3, // Durée d'affichage de 3 secondes
    backgroundColor: Colors.white,
    textColor: Colors.purple,
    fontSize: 16.0,
  );
}