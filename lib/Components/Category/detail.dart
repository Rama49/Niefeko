import 'package:flutter/material.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';
//import 'package:flutter/cupertino.dart';

class Detail extends StatelessWidget{
  final Product product;
  const Detail({super.key, required this.product});
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Color(0xFF593070),
    body: Column(
      children: [
        SizedBox(height: 36),
       Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(),
                    ),
                  );
                },
                style: IconButton.styleFrom(
                    //backgroundColor: Colors.white,
                    fixedSize: const Size(55, 55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined,color: Colors.white,)),
              //IconButton(
          //       icon: Icon(
          //       isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
          //       color: isFavoritedList[index] ? Colors.red : Colors.white,
          //     ),
          //       onPressed: () {
          //           setState(() {
          //         isFavoritedList[index] = !isFavoritedList[index];
          //       });

          //       // Vérifiez si le produit est ajouté aux favoris
          //       if (isFavoritedList[index]) {
          //         // Créez une instance de produit
          //         Product favoriteProduct = Product(
          //           imagePath: imagePaths[index],//'assets/gourde.png',
          //           name: names[index],//imageName,//'Gourde',
          //           price: 1111 //price,
          //         );

          //         // Ajouter le produit aux favoris dans Firestore
          //         addFavoriteToFirestore(favoriteProduct);
          //       }
          //       },
          //       style: IconButton.styleFrom(
          //           //backgroundColor: Colors.white,
          //           fixedSize: const Size(55, 55),
          //           shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(15))),
          //       //icon: Icon(Icons.favorite_border_outlined, color: Colors.white,),
          // )],
      ]),
          Container(
            height: MediaQuery.of(context).size.height * .25,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.asset(product.imagePath),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 15, left: 40, right: 40)),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 25,
                            color: Color(0xFF593070),
                          ),
                        ),
                       // Row(
                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //children: [
                            // Text(
                            //   'Dans notre nouvelle collection',
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w600,
                            //     color: Color(0xFF593070),
                            //   ),
                            // ),
                          //],
                        //),
                        Text(
                          '${product.price}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF593070),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(right: 6),
                              width: 200,
                              //height: 10,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(40),
                              ),

                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                        height: 70,
                                        image: AssetImage('sac.jpg')),
                                    Text(
                                      "Sac à main",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      
bottomNavigationBar: Container(
        height: 100,
        color: Color(0xFF593070),
        //padding: EdgeInsets.symmetric(horizontal: 20),
        // alignment: Alignment.center,
        // width: double.infinity,
        // height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(color: Color(0xFF593070),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(10),
        //   topRight: Radius.circular(10)
        // )
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {
                          //if (quantity > 1) {
                         // quantity -= 1;
                          //setState(() {});
                         // }
                        },
                         icon: Icon(Icons.remove)
                         ),
                  const SizedBox(width: 4,),
                  Text(''),
                    //"$quantity",
                    //style: TextStyle(
                      //fontSize: 20,
                    //),
                  //),
                  const SizedBox(width: 4,),
                  IconButton(onPressed: () {
                     //quantity += 1;
                    //setState(() {});
                  },
                  icon: Icon(Icons.add)
                 )
                ],
              ),
            ),

           const SizedBox(width: 5),

            Expanded(
              child: ElevatedButton(onPressed: () => (),
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    '+ Add to Cart',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF593070),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}

  