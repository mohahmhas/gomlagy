import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/widget/product_card/product_item_vertical.dart';

class WishListVerticalCats extends ConsumerWidget {
  final catData;
  final String url;
  final int countOfItems;
  WishListVerticalCats({this.catData, this.url, this.countOfItems});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final providerCatData = watch(catData);

    return FutureBuilder(
        future: providerCatData.fetchAndSetWishlistData(url),
        builder: (ctx, snaptshot) {
          if (snaptshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          print(snaptshot.data);
          List<Widget> list = [];
          list = List.from(snaptshot.data.take(countOfItems).map((e) {
            print('name = ${e.name}');
            return ProductItemVertical(
              name: e.name,
              rating: e.rating,
              image: e.thumbnailImage,
              unitPrice: e.unitPrice,
              unitPrice2: e.unitPrice2,
              unitPrice3: e.unitPrice3,
              
            );
          }));

          return Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
           // color: Colors.white,
            //   height: MediaQuery.of(context).size.height * 0.26,
            child: Wrap(
              //verticalDirection: tr,
              children: list,
            ),
          );
        });
  }
}
