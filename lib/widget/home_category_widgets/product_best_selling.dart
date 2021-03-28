import 'package:flutter/material.dart';
import 'package:gomalgy/widget/product_card/product_item_vertical.dart';
import '../../helpers/base_url.dart' as baseurl;

class BestSelling extends StatefulWidget {
  @override
  _BestSellingState createState() => _BestSellingState();
}

class _BestSellingState extends State<BestSelling> {
  @override
  Widget build(BuildContext context) {
    List list = [
      {
        'name': 'mohamed',
        'thumbnailImage':
            'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
        'rating': double.parse('1'),
        'unitPrice': double.parse('1'),
        'unitPrice2': double.parse('1'),
        'unitPrice3': double.parse('1'),
      }
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Best Selling',
            style: TextStyle(
                fontSize: 20,
                color: Colors.orange[900],
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.26,
          child: ListView.builder(
            itemBuilder: (ctx, i) => ProductItemVertical(
              name: list[i]['name'],
              image: list[i]['thumbnailImage'],
              rating: list[i]['rating'],
              unitPrice: list[i]['unitPrice'],
              unitPrice2: list[i]['unitPrice2'],
              unitPrice3: list[i]['unitPrice3'],
            ),
            itemCount: (list.length),
          ),
        ),
      ],
    );
  }
}
