import 'package:flutter/material.dart';
import 'package:curved_bottom_navigation/curved_bottom_navigation.dart';
import 'package:gomalgy/screens/naviation_bottom/ViewModel.dart';
import 'package:gomalgy/screens/naviation_bottom/all_products.dart';
import 'package:gomalgy/screens/naviation_bottom/home.dart';
import 'package:gomalgy/screens/naviation_bottom/shop_card.dart';
import 'package:gomalgy/screens/naviation_bottom/user_navigation.dart';

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
          ViewModel(),
          AllProducts(),
          ShopCard(),
          UserNav(),
        ],
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: CurvedBottomNavigation(
            navHeight: 50,
            fabSize: 50,
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
              Icon(Icons.view_module_rounded, color: Colors.white),
              Icon(Icons.search, color: Colors.white),
              Icon(Icons.shopping_cart, color: Colors.white),
              Icon(Icons.account_circle_sharp, color: Colors.white),
            ],
          ))
    ]);
  }
}
