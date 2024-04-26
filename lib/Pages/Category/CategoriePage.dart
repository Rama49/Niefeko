import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // Liste de booléens pour suivre l'état de favori de chaque élément
  List<bool> isFavoritedList = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
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
              color: Colors.purple,
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.purple),
                    // suffixIcon: Icon(Icons.shopping_cart, color: Colors.purple), // Ajouter une icône de panier à droite du champ de recherche
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('../assets/tshirt1.jpg'),
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
              itemCount: 10,
              itemBuilder: (context, index) {
                return buildCard(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  '../assets/tshirt1.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0, // Aligner l'icône en bas
                  right: 0, // Aligner l'icône à droite
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Title $index',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Action à exécuter lors du clic sur le bouton
                },
                // Icône du panier
                label: Text(
                  'Ajouter au',
                  style: TextStyle(fontSize: 16, color: Colors.white), // Couleur de l'écriture
                ),
                icon: Icon(Icons.shopping_cart, color: Colors.white), 
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  primary: Colors.purple, // Couleur de fond violette
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
