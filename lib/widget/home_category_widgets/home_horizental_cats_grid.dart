import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/widget/product_card/product_cart_%20vertical.dart';

class HomeHorizentalGridCat extends ConsumerWidget {
  final catData;
  final String url;
  final int countOfItems;
  final String arrayKey;

  HomeHorizentalGridCat(this.catData, this.url, this.countOfItems,
      {this.arrayKey = ''});
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Listens to the value exposed by counterProvider

    final featuredData = watch(catData);
    //featuredData.fetchAndSetProducts();
    Future Check() async {
      if (url != null) {
        return arrayKey == ''
            ? await featuredData.fetchAndSetCatdData(url)
            : featuredData.items[arrayKey];
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
            return ProductCardvertical(
              id: e.id,
              name: e.name,
              rating: e.rating,
              thumbnailImage: e.thumbnailImage,
              unitPrice: e.unitPrice,
              unitPrice2: e.unitPrice2,
              unitPrice3: e.unitPrice3,
            );
          }));

          return Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,

            alignment: WrapAlignment.start,

            //textDirection: TextDirection.rtl,
            runAlignment: WrapAlignment.start,
            runSpacing: 3.0,
            spacing: 5.0,

            // verticalDirection: VerticalDirection.up,
            children: list,
          );
        });

    // imgList == null || imgList.length == 0
    //     ? CircularProgressIndicator()
    //     : SliderWidgetView(imgList: imgList);
  }
}
