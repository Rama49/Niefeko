class Product {
  late final String imagePath;
  late final String name;
  late final String description;
  late final double price;
  int quantity ;

  Product({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    this.quantity = 1, required id,
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
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
     imagePath: json['images'][0]['src'] ?? '',
     name: json['name'] ?? '',
     description: json['description'] ?? '',
     price: double.parse(json['price'] ?? '0.0'),
    );
  }
}
