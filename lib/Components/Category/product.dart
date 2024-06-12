class Product {
  final String imagePath;
  final String name;
  final String description;
  final double price;
  int quantity ;

  Product({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    this.quantity = 1,
  });

  get id => null;

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'name': name,
      'description': description,
      'price': price,
    };
  }
}
