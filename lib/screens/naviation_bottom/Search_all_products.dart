import 'package:flutter/material.dart';
import 'package:gomalgy/widget/search_widget/search_cat.dart';
import 'package:gomalgy/providers/home_categories.dart' as homeCat;

class SearchAllProducts extends StatefulWidget {
  @override
  _SearchAllProductsState createState() => _SearchAllProductsState();
}

class _SearchAllProductsState extends State<SearchAllProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SearchCats(),
    );
  }
}
