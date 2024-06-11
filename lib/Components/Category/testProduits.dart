//    class Product {
//      final int id;
//      final String name;
//      //final String description;
//      final double price;
//      final String imagePath;

//      Product({
//        required this.id,
//        required this.name,
//        //required this.description,
//        required this.price,
//        required this.imagePath,
//      });

// factory Product.fromJson(Map<String, dynamic> json) {
//          return Product(
//          id: json['id'],
//          name: json['name'].toString(),
//          //description: json['description'].toString(),
//          price: json['price'] != null ? double.parse(json['price']) : 0.0,//json['price'] == null ? 0.0 : json['price'].toDouble,//json['price'],
//          imagePath: json['imagePath'].toString(),
//        );
//      }
//    }
