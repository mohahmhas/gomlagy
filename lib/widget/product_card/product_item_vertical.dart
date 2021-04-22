import 'package:flutter/material.dart';

import '../rating.dart';
import '../../helpers/base_url.dart' as baseurl;

/////// not using this class 

class ProductItemVertical extends StatelessWidget {
  final String name;
  final String image;
  final double rating;
  final double unitPrice;
  final double unitPrice2;
  final double unitPrice3;

  ProductItemVertical(
      {this.name,
      this.image,
      this.rating,
      this.unitPrice,
      this.unitPrice2,
      this.unitPrice3});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(baseurl.Urls.public_api + '/' + image),
                fit: BoxFit.fill,
                onError: (o, e) {
                  print(o);
                },
              )),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Text(name,
                          //   textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Rating(itemSize: 20, initialRating: rating),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(unitPrice.toString(),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w800)),
                  Text(unitPrice2.toString(),
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                          fontWeight: FontWeight.w800)),
                  Text(unitPrice3.toString(),
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
