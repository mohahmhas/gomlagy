import 'package:flutter/material.dart';
import 'package:curved_bottom_navigation/curved_bottom_navigation.dart';
import 'package:gomalgy/screens/navigatBottom/all_products.dart';
import 'package:gomalgy/screens/navigatBottom/shop_card.dart';
import '../screens/navigatBottom/home.dart';

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
          AllProducts(),
          ShopCard(),
        ],
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: CurvedBottomNavigation(
            bgColor: Theme.of(context).primaryColor,
            fabBgColor: Theme.of(context).primaryColor,
            selected: navPos,
            onItemClick: (i) {
              setState(() {
                navPos = i;
              });
            },
            items: [
              Icon(Icons.home, color: Colors.white),
              Icon(Icons.search, color: Colors.white),
              Icon(Icons.shopping_cart, color: Colors.white),
              // Icon(Icons.notifications, color: Colors.white),
              // Icon(Icons.settings, color: Colors.white),
            ],
          ))
    ]);
  }
}
