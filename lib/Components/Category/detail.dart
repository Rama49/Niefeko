//import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';
import 'package:niefeko/Pages/Connexion/conexion.dart';

class detail extends StatelessWidget {
  detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    return Scaffold(
      backgroundColor: Color(0xFF593070),
      body: Column(
        children: [
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
                icon: const Icon(CupertinoIcons.chevron_back),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                    //backgroundColor: Colors.white,
                    fixedSize: const Size(55, 55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                icon: Icon(Icons.favorite_border),
                color: Colors.white,
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * .25,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.asset('assets/gourde.png'),
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
                  padding: const EdgeInsets.all(20),
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
                          'Sac à main',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF593070),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dans notre nouvelle collection',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF593070),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '5000 XOF',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF593070),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Un sac à main, est un accessoire de mode qui permet de ranger des objets utiles au quotidien, comme les clés, ',
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
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              //alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //IconButton(
                  //onPressed: () {
                  // if (quantity > 1) {
                  //quantity -= 1;
                  //setState(() {});
                  //}
                  //},
                  // icon: const Icon(
                  //Icons.remove,
                  // color: Colors.black,
                  // ),
                  // ),

                  CircleAvatar(
                    //radius: 22,
                    backgroundColor: Colors.white,
                    child:
                        IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
                  ),

                  Text(
                    "0",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
//                    Text(
//                             "$quantity",
//                             style: const TextStyle(
//                                 color: Colors.black, fontSize: 25),
//                           ),
//  IconButton(
//                             onPressed: () {
//                               quantity += 1;
//                               //setState(() {});
//                             },
//                             icon: const Icon(
//                               Icons.add,
//                               color: Colors.black,
//                             ),
//                           ),

                  CircleAvatar(
                      // radius: 22,
                      backgroundColor: Colors.white,
                      child:
                          IconButton(onPressed: () {}, icon: Icon(Icons.add)))
                ],
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: InkWell(
                onTap: () {
                  //productController.addToCart();
                },
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
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
