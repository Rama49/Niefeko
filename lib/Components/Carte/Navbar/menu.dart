import 'package:flutter/material.dart';

class MyMenu extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Menu latéral'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(), // Concise null-safe approach
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Page 1'),
              onTap: () {
                Navigator.pushNamed(context, '/page1');
              },
            ),
            ListTile(
              title: Text('Page 2'),
              onTap: () {
                Navigator.pushNamed(context, '/page2');
              },
            ),
          ],
        ),
      ),
    );
  }
}
