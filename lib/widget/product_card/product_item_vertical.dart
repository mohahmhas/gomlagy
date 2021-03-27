import 'package:flutter/material.dart';

import '../rating.dart';

class ProductItemVertical extends StatelessWidget {
  final String name;
  final String image;

  ProductItemVertical(this.name, this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 160.0,
      color: Colors.green,
      child: Row(
        children: [
          Image.network(image),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(name),
              ),
              Rating(),
            ],
          ),
        ],
      ),
    );
  }
}
