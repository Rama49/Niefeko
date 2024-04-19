import 'package:flutter/material.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("../../assets/imagedecouverture.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 250, right: 5, left: 5),
        child: SizedBox(
          height: 45,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xfff1f1f1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: "recherche un produit",
              prefixIcon: const Icon(Icons.search),
              prefixIconColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}









































// import 'package:flutter/material.dart';
// import 'package:niefeko/Components/Carte/carte.dart';
// import 'package:niefeko/Reutilisable/carteReu.dart';

// void main() => runApp(const search());

// class search extends StatefulWidget {
//   const search({super.key});

//   @override
//   State<search> createState() => _searchState();
// }

// class _searchState extends State<search> {
//   bool isDark = false;

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData themeData = ThemeData(
//         useMaterial3: true,
//         brightness: isDark ? Brightness.dark : Brightness.light);

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: themeData,
//       home: Container(
        
//           child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SearchAnchor(
//             builder: (BuildContext context, SearchController controller) {
//           return Container(
//             child: SearchBar(
//               controller: controller,
//               padding: const MaterialStatePropertyAll<EdgeInsets>(
//                   EdgeInsets.symmetric(horizontal: 16.0)),
//               onTap: () {
//                 controller.openView();
//               },
//               onChanged: (_) {
//                 controller.openView();
//               },
//               leading: const Icon(Icons.search),
//               trailing: <Widget>[
//                 Tooltip(
//                   message: 'Change brightness mode',
//                   child: IconButton(
//                     isSelected: isDark,
//                     onPressed: () {
//                       setState(() {
//                         isDark = !isDark;
//                       });
//                     },
//                     icon: const Icon(Icons.wb_sunny_outlined),
//                     selectedIcon: const Icon(Icons.brightness_2_outlined),
//                   ),
//                 )
//               ],
//             ),
//           );
//         }, suggestionsBuilder:
//                 (BuildContext context, SearchController controller) {
//           return List<ListTile>.generate(5, (int index) {
//             final String item = 'item $index';
//             return ListTile(
//               title: Text(item),
//               onTap: () {
//                 setState(() {
//                   controller.closeView(item);
//                 });
//               },
//             );
//           });
//         }),
//       )),
//     );
//   }
// }
