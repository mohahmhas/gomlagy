import 'package:flutter/material.dart';
import 'package:gomlgy/screens/account_information/account_information_page.dart';
import 'package:gomlgy/widget/navigationBar.dart';
import './widget/drawer.dart';

class MainPgae extends StatefulWidget {
  static String id = '/MainPage';
  @override
  _MainPgaeState createState() => _MainPgaeState();
}

class _MainPgaeState extends State<MainPgae> {
//drawer
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Navigat(), // initDetailsPage(),
      ),
    );
  }
}
