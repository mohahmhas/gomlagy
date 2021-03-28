import 'package:flutter/material.dart';
import 'package:gomalgy/widget/rating.dart';
import '../../helpers/base_url.dart' as baseurl;

class ProductCardHorizental extends StatelessWidget {
  final String name;
  final String thumbnailImage;

  final double unitPrice;
  final double rating;

  final double unitPrice2;
  final double unitPrice3;

  const ProductCardHorizental(
      {Key key,
      this.name,
      this.rating,
      this.thumbnailImage,
      this.unitPrice,
      this.unitPrice2,
      this.unitPrice3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                  baseurl.Urls.public_api + '/' + thumbnailImage,
                ),
                fit: BoxFit.cover,
                onError: (o, e) {
                  print(o);
                },
              )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(name),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Rating(
                itemSize: 11,
                initialRating: rating,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 150,
            color: Colors.grey.withOpacity(0.2),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      unitPrice.toString() + 'ج.م',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        unitPrice2.toString() + 'ج.م',
                        textAlign: TextAlign.left,
                      ),
                    )),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        unitPrice2.toString() + 'ج.م',
                        textAlign: TextAlign.right,
                      ),
                    )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
