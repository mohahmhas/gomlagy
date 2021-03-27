import 'package:flutter/material.dart';

class ProductCardHorizental extends StatelessWidget {
  const ProductCardHorizental({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
         decoration: BoxDecoration(image:  DecorationImage(
                        image: NetworkImage(), fit: BoxFit.cover)),),
              
             
          )
        ],
      ),
    );
  }
}
