import 'package:flutter/material.dart';
import 'package:gomlgy/widget/search_widget/search_cat.dart';
import 'package:gomlgy/providers/home_categories.dart' as homeCat;

class SearchAllProducts extends StatefulWidget {
  @override
  _SearchAllProductsState createState() => _SearchAllProductsState();
}

class _SearchAllProductsState extends State<SearchAllProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .75,
          child: SearchCats(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        )
      ],
    );
  }
}
