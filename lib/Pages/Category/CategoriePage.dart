import 'package:flutter/material.dart';
import 'package:niefeko/Components/Carte/Recherche/recherche.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // Liste de booléens pour suivre l'état de favori de chaque élément
  List<bool> isFavoritedList = List.generate(20, (index) => false);

  // Liste des chemins des nouvelles images
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

  // Liste des prix correspondant à chaque produit
  List<double> prices = List.generate(20, (index) => 1000.0);

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
            icon: Icon(Icons.shopping_cart, color: Colors.white),
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
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    // suffixIcon: Icon(Icons.shopping_cart, color: Colors.purple), // Ajouter une icône de panier à droite du champ de recherche
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
                    imagePaths.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(imagePaths[index]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 20,
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
    // Extraire le nom du fichier de l'image
    String imageName = imagePaths[index].split('/').last.split('.').first;
    // Extraire le prix correspondant à l'index
    double price = prices[index];
    return Card(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePaths[index], // Utiliser le chemin d'image correspondant à l'index
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      imageName, // Utiliser le nom de l'image comme titre
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$$price', // Afficher le prix
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Action à exécuter lors du clic sur le bouton
                  },
                  // Icône du panier à droite du texte
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
