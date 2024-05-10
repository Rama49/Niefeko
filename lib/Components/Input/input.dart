import 'package:flutter/material.dart';

class input extends StatelessWidget {
  const input({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
                    height: 40,
                    padding: EdgeInsets.only(right: 25, left: 25),
                    child: TextField(
                      // onChanged: searchProduct,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 3,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Rechercher un produit",
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.black,
                      ),
                    ),
                  );
  }
}