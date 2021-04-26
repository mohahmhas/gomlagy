import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomlgy/widget/product_card/product_cart_%20horizontal.dart';

class HomeHorizentalCat extends ConsumerWidget {
  final catData;
  final String url;
  final String arrayKey;

  HomeHorizentalCat(this.catData, this.url, {this.arrayKey = ''});
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

          return Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              //  scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),

              itemCount: snaptshot.data.length,
              itemBuilder: (ctx, i) => ProductCardHorizental(
                id: snaptshot.data[i].id.toString(),
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
