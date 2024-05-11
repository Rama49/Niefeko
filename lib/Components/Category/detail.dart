import 'package:flutter/material.dart';
import 'package:niefeko/Components/Category/product.dart';
import 'package:niefeko/Pages/Category/CategoriePage.dart';

class Detail extends StatelessWidget {
  final product;
  
  const Detail({Key? key, required this.product}) : super(key: key);
  
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
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(
                  isFavoritedList[index] ? Icons.favorite : Icons.favorite_border_outlined,
                  color: isFavoritedList[index] ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  // Toggle favorite status and add to Firestore
                  setState(() {
                    isFavoritedList[index] = !isFavoritedList[index];
                  });

                  if (isFavoritedList[index]) {
                    Product favoriteProduct = Product(
                      imagePath: imagePaths[index],
                      name: names[index],
                      price: 1111,
                    );

                    addFavoriteToFirestore(favoriteProduct);
                  }
                },
                color: Colors.white,
              ),
            ],
          ),
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
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 40, right: 40),
            child: Expanded(
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
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                      height: 70,
                                      image: AssetImage('sac.jpg'),
                                    ),
                                    Text(
                                      "Sac à main",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
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
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Color(0xFF593070),
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
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    '',
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
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
