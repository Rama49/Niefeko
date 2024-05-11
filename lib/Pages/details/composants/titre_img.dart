// import 'package:flutter/material.dart';
// import 'package:niefeko/model/Product.dart';

// class TitreImg extends StatelessWidget {
//   const TitreImg({super.key, required this.product});

//   final Product product;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 2),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             "Notre Collection",
//             style: TextStyle(color: Colors.white),
//           ),
//           Text(
//             product.name,
//             style: Theme.of(context)
//                 .textTheme
//                 .titleLarge!
//                 .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 2),
//           Row(
//             children: <Widget>[
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(text: "Price\n"),
//                     TextSpan(
//                       text: "\$${product.price}",
//                       style: Theme.of(context)
//                           .textTheme
//                           .headlineSmall!
//                           .copyWith(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 2),
//               Expanded(
//                 //child: Hero(
//                   //tag: "${product.id}",
//                   child: Image.asset(
//                     product.imgProduct,
//                     fit: BoxFit.fill,
//                   //),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
