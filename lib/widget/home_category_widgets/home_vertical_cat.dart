import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/widget/product_card/product_item_vertical.dart';

class HomeVerticalCats extends ConsumerWidget {
  final catData;
  final String url;
  final int countOfItems;
  final String arrayKey;

  HomeVerticalCats(
      {this.catData, this.url, this.countOfItems, this.arrayKey = ''});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final providerCatData = watch(catData);
    Future Check() async {
      if (url != null) {
        return arrayKey == ''
            ? await providerCatData.fetchAndSetCatdData(url)
            : providerCatData.items[arrayKey];
      }
    }

    return FutureBuilder(
        future: Check(),
        builder: (ctx, snaptshot) {
          if (snaptshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          print(snaptshot.data);
          List<Widget> list = [];
          list = List.from(snaptshot.data.take(countOfItems).map((e) {
            return ProductItemVertical(
              id: e.id,
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
