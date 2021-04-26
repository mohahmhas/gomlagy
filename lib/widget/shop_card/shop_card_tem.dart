import 'package:flutter/material.dart';
import 'package:gomlgy/widget/rating.dart';
import '../../helpers/base_url.dart' as baseurl;
import 'package:gomlgy/screens/details_prodect/details_page.dart';

class ShopCardTem extends StatelessWidget {
  // final String name;
  // final String thumbnailImage;

  // final double unitPrice;
  // final double rating;

  // final double unitPrice2;
  // final double unitPrice3;

  // const ShopCardTem(
  //     {Key key,
  //     this.name,
  //     this.rating,
  //     this.thumbnailImage,
  //     this.unitPrice,
  //     this.unitPrice2,
  //     this.unitPrice3})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.16,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: NetworkImage(
                                    'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
                                    // baseurl.Urls.public_api + '/' + thumbnailImage,
                                    scale: 10,
                                  ),
                                  fit: BoxFit.fill,
                                  onError: (o, e) {
                                    print(o);
                                  },
                                )),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'gakgnakegnlakgn',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '1000.00 E.G',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: Theme.of(context).primaryColor,
                                          size: 35,
                                        ),
                                        onPressed: () {})),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    ' 0',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Theme.of(context).primaryColor),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Theme.of(context).primaryColor,
                                          size: 35,
                                        ),
                                        onPressed: () {})),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
