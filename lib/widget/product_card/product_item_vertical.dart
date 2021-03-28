import 'package:flutter/material.dart';

import '../rating.dart';
import '../../helpers/base_url.dart' as baseurl;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //height: MediaQuery.of(context).size.height * 0.2,
            //width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(
                                baseurl.Urls.public_api + '/' + image),
                            fit: BoxFit.fill,
                            onError: (o, e) {
                              print(o);
                            },
                          )),
                        ),
                      ),
                      Column(
                        children: [
                          Text(name,
                              style: TextStyle(
                                  color: Colors.black,
                                  // fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          SizedBox(
                            height: 20,
                          ),
                          Rating(itemSize: 20, initialRating: rating),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w800)),
                        Text(unitPrice3.toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
