import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';


class carteReu extends StatefulWidget {
  const carteReu({super.key});

  @override
  State<carteReu> createState() => _carteReuState();
}

class _carteReuState extends State<carteReu> {
  @override
  Widget build(BuildContext context) {
    return 
     Column(
      children: [
        FlutterCarousel(
  options: CarouselOptions(
    height: 800.0, 
    showIndicator: true,
    slideIndicator: CircularSlideIndicator(),
  ),
  items: [1,2,3,4,5].map((i) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
         
          child: 
           Image.asset(
                    '../../assets/logoNiefeko.png', // Remplacez par le chemin de votre logo
                    width: 100, // Ajustez la hauteur du logo selon vos besoins
                  ),
        );
      },
    );
  }).toList(),
)

      ],
    );
  }
  
}