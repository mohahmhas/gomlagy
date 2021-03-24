import 'package:flutter/material.dart';
import 'package:curved_bottom_navigation/curved_bottom_navigation.dart';
import '../screens/home.dart';

class Navigat extends StatefulWidget {
  @override
  _NavigatState createState() => _NavigatState();
}

class _NavigatState extends State<Navigat> {
  var navPos = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IndexedStack(
        index: navPos,
        children: [
          Home(),
        ],
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: CurvedBottomNavigation(
            selected: navPos,
            onItemClick: (i) {
              setState(() {
                navPos = i;
              });
            },
            items: [
              Icon(Icons.search, color: Colors.white),
              // Icon(Icons.star, color: Colors.white),
              // Icon(Icons.home, color: Colors.white),
              // Icon(Icons.notifications, color: Colors.white),
              // Icon(Icons.settings, color: Colors.white),
            ],
          ))
    ]);
  }
}
