import 'package:flutter/material.dart';
import 'package:gomalgy/widget/rating.dart';
import '../../helpers/base_url.dart' as baseurl;

class ProductCardHorizental extends StatelessWidget {
  const ProductCardHorizental({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 150,
        width: 150,
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
                    baseurl.Urls.public_api +
                        '/uploads/all/EUVhpp6F3hBgCpjCd6NoZGmtHv5lhEyPeNG6Jq9g.jpeg',
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
            Text('ddd'),
            Row(
              children: [
                Rating(
                  itemSize: 11,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
