class Product {
  final String imagePath;
  final String name;
  final String description;
  final double price;
  final int id;
  int quantity; // Peut-être supprimé si non utilisé globalement.

  Product({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    required this.id,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'imagePath': imagePath,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      imagePath: json['featured_image']['url'] ?? 'assets/images/default_image.png', // Utilisation d'une image de secours si l'image n'est pas présente.
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: double.parse(json['price'].toString() ?? '0.0'),
    );
  }
}
