import 'package:flutter/material.dart';
import 'package:gomalgy/widget/product_card/product_item_vertical.dart';
import '../../helpers/base_url.dart' as baseurl;

class PestSilling extends StatefulWidget {
  @override
  _PestSillingState createState() => _PestSillingState();
}

class _PestSillingState extends State<PestSilling> {
  @override
  Widget build(BuildContext context) {
    List list = [
      {
        'name': 'mohamed',
        'thumbnailImage': baseurl.Urls.public_api +
            '/uploads/all/EUVhpp6F3hBgCpjCd6NoZGmtHv5lhEyPeNG6Jq9g.jpeg',
        'rating': 1.4,
        'unitPrice': 12,
        'unitPrice2': 14,
        'unitPrice3': 20
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
          color: Colors.red,
          height: MediaQuery.of(context).size.height * 0.26,
          child: ListView.builder(
            itemBuilder: (ctx, i) =>
                ProductItemVertical(list[i]['name'], list[i]['thumbnailImage']),
            itemCount: list.length,
          ),
        ),
      ],
    );
  }
}
