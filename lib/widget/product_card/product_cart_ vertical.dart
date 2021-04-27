import 'package:flutter/material.dart';
import 'package:gomlgy/screens/details_prodect/details_page.dart';
import 'package:gomlgy/widget/rating.dart';
import '../../helpers/base_url.dart' as baseurl;

class ProductCardvertical extends StatelessWidget {
  final String name;
  final String thumbnailImage;
  final String id;

  final double unitPrice;
  final double rating;

  final double unitPrice2;
  final double unitPrice3;

  const ProductCardvertical(
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
        print('--------tap' + id.toString());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => initDetailsPage(),
            settings: RouteSettings(arguments: id)));
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .35,
        width: MediaQuery.of(context).size.width / 2.1,
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * .15,
                width: MediaQuery.of(context).size.width * .30,
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
              height: 3,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .05,
              // color: Colors.red[100],
              child: Text(name,
                  //textScaleFactor: ,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 2,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis),
            ),
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
              height: 3,
            ),
            Container(
              // width: 150,
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
      ),
    );
  }
}
