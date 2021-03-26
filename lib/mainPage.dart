import 'package:flutter/material.dart';
import 'package:gomalgy/widget/custom_appBar.dart';
import 'package:gomalgy/widget/navigationBar.dart';
import './widget/drawer.dart';

class MainPgae extends StatefulWidget {
  static String id = 'MainPage';
  @override
  _MainPgaeState createState() => _MainPgaeState();
}

class _MainPgaeState extends State<MainPgae> {
  final GlobalKey<ScaffoldState> drawerKey =
      GlobalKey<ScaffoldState>(); //drawer
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: drawerKey,
        drawer: CustomDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomAppBar(drawerKey: drawerKey), //appBar
            Positioned(bottom: 0, child: Navigat()), //Navigaation
          ],
        ),
      ),
    );
  }
}
