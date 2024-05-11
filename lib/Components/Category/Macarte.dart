import 'package:flutter/material.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

class Macarte extends StatelessWidget{
  final product;
  const Macarte({super.key, required this.product});
  
  @override 
  //State<Macarte> createState() => _Macarte();

  Widget build(BuildContext context){
    return
    Scaffold(body: Column(children: [
       Card(
child: 
 Stack(
      children: 
        [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                product.imagePath,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '{$product.price}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () {},//=> addToCart(index),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ajouter au',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Icon(Icons.shopping_cart, color: Colors.white),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    backgroundColor: Color(0xFF612C7D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment(1, -1),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined))
            // IconButton(
            //   icon: Icon(
            //     isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
            //     color: isFavoritedList[index] ? Colors.red : Colors.grey,
            //   ),
            //   onPressed: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => pageFavoris()),
            //     // );

            //     setState(() {
            //       isFavoritedList[index] = !isFavoritedList[index];
            //     });

            //     // Vérifiez si le produit est ajouté aux favoris
            //     if (isFavoritedList[index]) {
            //       // Créez une instance de produit
            //       Product favoriteProduct = Product(
            //         imagePath: product.imagePath,
            //         name: product.name,
            //         description: product.description,
            //         price: product.price,
            //       );

            //       // Ajouter le produit aux favoris dans Firestore
            //       addFavoriteToFirestore(favoriteProduct);
            //     }
            //   },
            // ),
          ),
        ],
      
    ),)
  
    ],));
  }
}