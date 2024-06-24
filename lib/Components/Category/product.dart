class Product {
  final int id;
  final String imagePath;
  final String name;
  final String description;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'],
    imagePath: json['images'] != null && json['images'].isNotEmpty
        ? json['images'][0]['src'] ?? ''  // Handle the case where 'images' is null or empty
        : '',
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    price: double.parse(json['price'] ?? '0.0'),
    quantity: json['quantity'] ?? 1,
  );
}
}