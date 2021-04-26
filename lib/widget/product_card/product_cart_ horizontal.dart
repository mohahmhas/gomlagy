import 'package:flutter/material.dart';
import 'package:gomlgy/widget/rating.dart';
import '../../helpers/base_url.dart' as baseurl;
import 'package:gomlgy/screens/details_prodect/details_page.dart';

class ProductCardHorizental extends StatelessWidget {
  final String name;
  final String thumbnailImage;

  final double unitPrice;
  final double rating;
  final String id;
  final double unitPrice2;
  final double unitPrice3;

  const ProductCardHorizental(
      {Key key,
      this.id,
      this.name,
      this.rating,
      this.thumbnailImage,
      this.unitPrice,
      this.unitPrice2,
      this.unitPrice3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('----------id---' + id);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => initDetailsPage(),
            settings: RouteSettings(arguments: id)));
      },
      child: Container(
        // color: Colors.red[100],
        width: MediaQuery.of(context).size.width * .40,

        margin: EdgeInsets.symmetric(horizontal: 3),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .094,
                    width: MediaQuery.of(context).size.width * .30,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                        baseurl.Urls.public_api + '/' + thumbnailImage,
                      ),
                      fit: BoxFit.fitHeight,
                      onError: (o, e) {
                        print(o);
                      },
                    )),
                  ),
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * .009,
              // ),
              Flexible(
                flex: 1,
                child: Text(
                  name,
                  //   textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Rating(
                      itemSize: 11,
                      initialRating: rating,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .009,
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width * .40,
                  //height: MediaQuery.of(context).size.height * .079,
                  color: Colors.grey.withOpacity(0.2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            unitPrice.toString() + 'ج.م',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
