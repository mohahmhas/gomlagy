import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomalgy/widget/product_card/product_cart_%20horizontal.dart';

class HomeHorizentalCat extends ConsumerWidget {
  final catData;
  final String url;
  HomeHorizentalCat(this.catData, this.url);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Listens to the value exposed by counterProvider

    final featuredData = watch(catData);
    //featuredData.fetchAndSetProducts();

    return FutureBuilder(
        future: featuredData.fetchAndSetCatdData(url),
        builder: (ctx, snaptshot) {
          if (snaptshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          print(snaptshot.data);

          return Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              //  scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),

              itemCount: snaptshot.data.length,
              itemBuilder: (ctx, i) => ProductCardHorizental(
                name: snaptshot.data[i].name,
                rating: snaptshot.data[i].rating,
                thumbnailImage: snaptshot.data[i].thumbnailImage,
                unitPrice: snaptshot.data[i].unitPrice,
                unitPrice2: snaptshot.data[i].unitPrice2,
                unitPrice3: snaptshot.data[i].unitPrice3,
              ),
            ),
          );
        });

    // imgList == null || imgList.length == 0
    //     ? CircularProgressIndicator()
    //     : SliderWidgetView(imgList: imgList);
  }
}
