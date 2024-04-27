import 'package:flutter/material.dart';
import 'package:niefeko/Components/Carte/Recherche/recherche.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<bool> isFavoritedList = List.generate(20, (index) => false);
  List<String> imagePaths = [
    '../assets/casque.png',
    '../assets/chaussure.png',
    '../assets/coquillage.png',
    '../assets/gourde.png',
    '../assets/jordan.png',
    '../assets/lunnete1.png',
    '../assets/lunette.png',
    '../assets/montre.png',
    '../assets/pantalon.png',
    '../assets/pot.png',
    '../assets/sac1.png',
    '../assets/sacoche.png',
    '../assets/shoes.png',
    '../assets/t-shirt.png',
    '../assets/torche.png',
    '../assets/tshirt-polo.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirtRouge.png',
    '../assets/torche.png',
    '../assets/tshirt-polo.jpg',
    '../assets/tshirt1.jpg',
    '../assets/tshirtRouge.png',
  ];
  List<double> prices = List.generate(20, (index) => 1000.0);
  List<String> filteredImagePaths = [];
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    filteredImagePaths.addAll(imagePaths);
  }

  void searchProduct(String query) {
    setState(() {
      filteredImagePaths = imagePaths.where((path) => path.contains(query)).toList();
    });
  }

  void addToCart() {
    setState(() {
      cartItemCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF612C7D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart, color: Colors.white),
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      cartItemCount.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Action à exécuter lors du clic sur l'icône de panier
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF612C7D),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                ),
                child: TextField(
                  onChanged: searchProduct,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: Color(0xFF612C7D),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: List.generate(
                    filteredImagePaths.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(filteredImagePaths[index]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Condition pour afficher "Produit non trouvé" si la liste filtrée est vide
            filteredImagePaths.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Produit non trouvé",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: filteredImagePaths.length,
                    itemBuilder: (context, index) {
                      return buildCard(index);
                    },
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF612C7D),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => search(),
                  ),
                );
              },
              icon: Icon(Icons.home, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(),
                  ),
                );
              },
              icon: Icon(Icons.favorite, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(),
                  ),
                );
              },
              icon: Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(int index) {
    String imageName = filteredImagePaths[index].split('/').last.split('.').first;
    double price = prices[index];
    return Card(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                filteredImagePaths[index],
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      imageName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$$price',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    addToCart(); // Ajouter au panier
                  },
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
                    primary: Color(0xFF612C7D),
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
            child: IconButton(
              icon: Icon(
                isFavoritedList[index] ? Icons.favorite : Icons.favorite_border,
                color: isFavoritedList[index] ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavoritedList[index] = !isFavoritedList[index];
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
